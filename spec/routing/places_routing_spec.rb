require 'spec_helper'

describe 'routes for Places' do

  it "should map { :controller => 'places', :action => 'index' } to /places" do
    expect(get "/places").to route_to(:controller => "places", :action => "index")
  end

  it "should map { :controller => 'places', :action => 'show_place', :name => 'puhoi' } to /places/puhoi" do
    expect(get "/places/puhoi").to route_to(:controller => "places", :action => "show_place", :name => 'puhoi')
  end


end
