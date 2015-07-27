require 'rails_helper'

RSpec.describe "user_permissions/show", type: :view do
  before(:each) do
    root = User.root_user || FactoryGirl.create(:root_user)
    @user_permission = assign(:user_permission, root.user_permission)
  end

  it "renders the user_permission in a table" do
    render

    assert_select "tr>th", :text => "User:"
    assert_select "tr>th", :text => "Is admin:"
    assert_select "tr>td", :text => @user_permission.user.human_email
    assert_select "tr>td", :text => /\A\s*#{Regexp.escape(@user_permission.is_admin.to_s)}/

  end
end
