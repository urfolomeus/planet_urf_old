require 'test_helper'
require 'yaml'

class FlickrTest < Test::Unit::TestCase
  fixtures :users
  
  def setup
    begin
      @flickr = Flickr.new(FLICKR_YAML_PATH)
    rescue Exception => e
      puts e.message
    end
  end
  
  def test_should_create_flickr_object
    assert_not_nil @flickr
  end
  
  def test_should_set_flickr_id
    flickr_id = get_flickr_id
    config_file = YAML.load_file(FLICKR_YAML_PATH)
    assert_equal config_file['flickr_id'], flickr_id
  end
  
  def test_should_retrieve_photos
    photos = user_photos
    assert_not_nil photos
    assert_equal 10, photos.count
  end
end