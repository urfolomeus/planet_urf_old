require 'yaml'

module FlickrHelper
  FLICKR_YAML_PATH = File.join(RAILS_ROOT, 'config', 'flickr.yml')
  
  def user_photos(user_id = nil, photo_count = 10)
    flickr = Flickr.new(FLICKR_YAML_PATH)
    user_id ||= get_flickr_id
    flickr.photos.search(:user_id => user_id).values_at(0..(photo_count - 1))
  end
  
  def render_flickr_sidebar_widget(user_id = nil, photo_count = 10, columns = 2)
    begin
      photos = user_photos(user_id, photo_count).in_groups_of(2)
      render :partial => '/flickr/sidebar_widget', :locals => { :photos => photos }
    rescue Exception
      render :partial => '/flickr/unavailable'
    end
  end
  
  def get_flickr_id
    begin
      config_file = YAML.load_file(FLICKR_YAML_PATH)
    rescue Exception => e
      puts e.message
    end
    config_file['flickr_id']
  end
end
