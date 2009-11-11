class ProjectsController < ApplicationController
  
  uses_tiny_mce :only     => [:new, :create, :edit, :update],
                :options  => {  :theme => 'advanced',
                                :theme_advanced_buttons1 => %w{ bold italic underline strikethrough | 
                                                                bullist numlist | 
                                                                outdent indent | },
                                :theme_advanced_buttons2 => %w{ undo redo | 
                                                                link unlink anchor image cleanup help code },
                                :theme_advanced_buttons3          => "",
                                :theme_advanced_toolbar_location  => 'top',
                                :theme_advanced_toolbar_align     => 'left',
                                :theme_advanced_resizing          => true,
                                :theme_advanced_resize_horizontal => false
                              }
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.find(:all, :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id], :include => :blogs)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    @project.save
    respond_to do |format|
      if @project.errors.empty?
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
