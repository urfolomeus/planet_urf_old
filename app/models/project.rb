class Project < ActiveRecord::Base
  has_many :blogs, :dependent => :nullify
  
  before_save :add_protocol_to_url, :unless => :url_has_protocol?
  
  validates_uniqueness_of :title
  validates_presence_of :title, :blurb
  
  private
  
  def url_has_protocol?
    self.url.blank? || self.url.include?("://")
  end
  
  def add_protocol_to_url
    self.url = "http://#{url}"
  end
end
