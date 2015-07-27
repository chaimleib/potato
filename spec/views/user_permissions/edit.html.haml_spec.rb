require 'rails_helper'

RSpec.describe "user_permissions/edit", type: :view do
  before(:each) do
    root = User.root_user || FactoryGirl.create(:root_user)
    @user_permission = root.user_permission
  end

  it "renders the edit user_permission form" do
    render

    assert_select "form[action=?][method=?]", user_permission_path(@user_permission), "post" do
      assert_select "input[disabled=disabled][value=?]", @user_permission.user.human_email
      assert_select "input#user_id[name=?]", "user_id"

      assert_select "input#user_permission_is_admin[name=?]", "user_permission[is_admin]"
    end
  end
end
