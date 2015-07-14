require 'rails_helper'

RSpec.describe "user_permissions/edit", type: :view do
  before(:each) do
    @user_permission = assign(:user_permission, UserPermission.create!(
      :user => nil,
      :is_admin => ""
    ))
  end

  it "renders the edit user_permission form" do
    render

    assert_select "form[action=?][method=?]", user_permission_path(@user_permission), "post" do

      assert_select "input#user_permission_user_id[name=?]", "user_permission[user_id]"

      assert_select "input#user_permission_is_admin[name=?]", "user_permission[is_admin]"
    end
  end
end
