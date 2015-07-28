require 'rails_helper'

RSpec.describe "resource_updates/index", type: :view do
  before(:each) do
    FactoryGirl.create(:root_user)
    @user = FactoryGirl.create(:user)
    @ru1 = FactoryGirl.create :resource_update
    @ru2 = FactoryGirl.create :resource_update, user: @user
    assign :resource_updates, [
      @ru1,
      @ru2
    ]
  end

  it "renders a list of resource_updates" do
    render
    assert_select "tr" do
      assert_select "th", "Name"
      assert_select "th", "Source URI"
      assert_select "th", "User"
      assert_select "th", "", count: 3
    end

    assert_select "tr>td", :text => @ru1.name, :count => 2
    assert_select "tr>td", :text => @ru1.source_uri, :count => 2
    assert_select "tr>td>a", :text => @ru1.user.full_name
    assert_select "tr>td>a", :text => @ru2.user.full_name
    assert_select "tr>td>a", "Show", count: 2
    assert_select "tr>td>a", "Edit", count: 2
    assert_select "tr>td>a", "Destroy", count: 2
  end
end
