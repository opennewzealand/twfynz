require 'spec_helper'

describe 'routes for Submissions' do

  it "should map { :controller => 'submissions', :action => 'index' } to /submissions" do
    expect(get "/submissions").to route_to(:controller => "submissions", :action => "index")
  end

  it "should map { :controller => 'submissions', :action => 'new' } to /submissions/new" do
    expect(get "/submissions/new").to route_to(:controller => "submissions", :action => "new")
  end

  it "should map { :controller => 'submissions', :action => 'show', :id => 1 } to /submissions/1" do
    expect(get "/submissions/1").to route_to(:controller => "submissions", :action => "show", :id => "1")
  end

  it "should map { :controller => 'submissions', :action => 'edit', :id => 1 } to /submissions/1/edit" do
    expect(get "/submissions/1/edit").to route_to(:controller => "submissions", :action => "edit", :id => "1")
  end

end
