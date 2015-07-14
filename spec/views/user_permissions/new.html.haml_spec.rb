require 'rails_helper'

RSpec.describe "user_permissions/new", type: :view do
  before(:each) do
    assign(:user_permission, UserPermission.new(
      :user => nil,
      :is_admin => ""
    ))
  end

  it "renders new user_permission form" do
    render

    assert_select "form[action=?][method=?]", user_permissions_path, "post" do

      assert_select "input#user_permission_user_id[name=?]", "user_permission[user_id]"

      assert_select "input#user_permission_is_admin[name=?]", "user_permission[is_admin]"
    end
  end
end
