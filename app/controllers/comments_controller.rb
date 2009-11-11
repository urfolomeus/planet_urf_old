class CommentsController < ApplicationController
  
  # GET /comments
  # GET /comments.xml
  def index
    if (params[:blog_id] == nil)
      @comments = Comment.find(:all)
    else
      @comments = Blog.find(params[:blog_id]).comments
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # POST /comments
  # POST /comments.xml
  def create
    @blog = Blog.find(params[:blog_id])
    @comment = @blog.comments.build(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @blog
    else
      render :action => 'new'
    end
  end
end
