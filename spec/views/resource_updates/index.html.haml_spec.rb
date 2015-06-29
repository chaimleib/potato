require 'rails_helper'

RSpec.describe "resource_updates/index", type: :view do
  before(:each) do
    @resource_update1 = FactoryGirl.build :resource_update
    @resource_update2 = @resource_update1.dup
    
    @resource_update1.save
    @resource_update2.save
  end

  it "renders a list of resource_updates" do
    render
    assert_select "tr>td", :text => @resource_update1.name, :count => 2
    assert_select "tr>td", :text => @resource_update1.source_uri, :count => 2
    assert_select "tr>td", :text => @resource_update1.user.name, :count => 2
  end
end
