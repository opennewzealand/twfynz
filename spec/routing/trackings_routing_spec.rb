require 'spec_helper'

describe 'routes for Trackings' do


  it "should map { :controller => 'trackings', :action => 'new' } to /trackings/new" do
    expect(get "/trackings/new").to route_to(:controller => "trackings", :action => "new")
  end


end
