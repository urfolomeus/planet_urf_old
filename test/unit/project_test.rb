require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  fixtures :projects

  test "should be valid with valid data" do
    project = new_project('http://www.example.com')
    assert project.valid?
  end

  test "should be invalid with empty attributes" do
    project = Project.new
    assert !project.valid?
    assert project.errors.invalid?(:title)
    assert project.errors.invalid?(:blurb)
  end
  
  test "should be invalid with duplicate title" do
    project = new_project
    project.title = projects(:planet_urf).title
    assert !project.valid?
    assert project.errors.invalid?(:title)
  end

  test "should not add protocol to URL that already has protocol" do
    project = new_project('http://www.example.com')
    assert project.save!
    assert_equal 'http://www.example.com', project.url
  end

  test "should add protocol to URL with no protocol" do
    project = new_project('www.example.com')
    assert project.save!
    assert_equal 'http://www.example.com', project.url
  end
  
  protected
  
  def new_project(url = '')
    Project.new(:title  => "New project",
                :blurb  => "<p>This is a new project</p>",
                :url    => url)
  end
end
