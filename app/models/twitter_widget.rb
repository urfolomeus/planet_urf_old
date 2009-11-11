require 'rubygems'
require 'twitter'
require 'yaml'

class TwitterWidget
  
  TWITTER_CONFIG = File.join(RAILS_ROOT, 'config', 'twitter.yml')
  
  def initialize
    @config = YAML.load_file(TWITTER_CONFIG)
    auth = Twitter::HTTPAuth.new(@config['user'], @config['password'])
    @twitter = Twitter::Base.new(auth)
  end
  
  def user_exists?
    !@twitter.verify_credentials.nil?
  end
  
  def timeline
    @twitter.user_timeline(:count => @config['tweets_per_fetch'])
  end
end