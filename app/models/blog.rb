class Blog < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  belongs_to :project
  
  validates_presence_of :title, :blurb
  validate :project_exists
  
  private
  
  def project_exists
    if !Project.exists?(project_id)
      errors.add(:project_id, "doesn't exist")
    end
  end
end
