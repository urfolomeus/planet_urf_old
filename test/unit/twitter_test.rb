require 'test_helper'
require 'yaml'

class TwitterTest < Test::Unit::TestCase
  def setup
    begin
      @config = YAML.load_file(TwitterWidget::TWITTER_CONFIG)
      @twitter = TwitterWidget.new
    rescue Exception => e
      puts e.message
    end
  end
  
  def test_should_instantiate_twitter_object
    assert_not_nil @twitter
  end
  
  def test_twitter_user_should_exist
    assert_equal true, @twitter.user_exists?
  end
  
  def test_should_retrieve_timeline
    timeline = fetch_timeline
    assert_not_nil timeline
  end
  
  def test_should_only_retrieve_specified_number_of_tweets
    timeline = fetch_timeline
    assert_equal @config['tweets_per_fetch'], timeline.count
  end
end
