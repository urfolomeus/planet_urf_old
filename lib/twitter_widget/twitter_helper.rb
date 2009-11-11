require 'rubygems'
require 'twitter'
require 'yaml'

module TwitterHelper
  def fetch_timeline
    twitter = TwitterWidget.new
    twitter.timeline
  end
  
  def render_twitter_sidebar_widget
    begin
      tweets = fetch_timeline
      render :partial => '/twitter/sidebar_widget', :locals => { :tweets => tweets }
    rescue Exception
      render :partial => '/twitter/unavailable'
    end
  end
end
