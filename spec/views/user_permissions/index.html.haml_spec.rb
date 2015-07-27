require 'rails_helper'

RSpec.describe "user_permissions/index", type: :view do
  before(:each) do
    root = User.root_user || FactoryGirl.create(:root_user)
    @user = FactoryGirl.create(:user)
    users = [
      root,
      @user
    ]
    assign :user_permissions, users.map(&:user_permission)
  end

  it "renders a list of user_permissions" do
    render
    assert_select "tr>th", :text => 'User first name'
    assert_select "tr>th", :text => 'User last name'
    assert_select "tr>th", :text => 'Is admin'
    assert_select "tr>td", :text => User.root_user.fname
    assert_select "tr>td", :text => User.root_user.lname
    assert_select "tr>td", :text => User.root_user.user_permission.is_admin.to_s

    assert_select "tr>td", :text => @user.fname
    assert_select "tr>td", :text => @user.lname
    assert_select "tr>td", :text => @user.user_permission.is_admin.to_s
  end
end
