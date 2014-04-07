require 'spec_helper'

describe 'routes for Users' do

  it "should map { :controller => 'submissions', :action => 'index' } to /submissions" do
    expect(get "/users/signup").to route_to(:controller => "user", :action => "signup")
  end

  it "should be accessible via route '/users/signup/organisation'" do
    expect(post "/users/signup/organisation").to route_to(:controller => "user", :action => "signup_organisation")
  end

  it "should be accessible via route '/users/signup/individual'" do
    expect(post "/users/signup/individual").to route_to(:controller => "user", :action => "signup_individual")
  end

end
