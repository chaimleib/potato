require 'rails_helper'

RSpec.describe "resource_updates/show", type: :view do
  before(:each) do
    FactoryGirl.create :root_user
    @resource_update = FactoryGirl.create :resource_update
  end

  it "renders attributes in a table" do
    render
    assert_select "tr" do
      assert_select "th", "Name:"
      assert_select "td", @resource_update.name
    end
    assert_select "tr" do
      assert_select "th", "Source URI:"
      assert_select "td", @resource_update.source_uri
    end
    assert_select "tr" do
      assert_select "th", "User:"
      assert_select "td", @resource_update.user.human_email
    end
  end
end
