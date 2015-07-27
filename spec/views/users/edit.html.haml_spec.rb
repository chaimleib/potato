require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign :user, FactoryGirl.create(:user)
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_fname[name=?]", "user[fname]"
      assert_select "input#user_lname[name=?]", "user[lname]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_password[type=password][name=?]", "user[password]"
      assert_select "input#user_password_confirmation[type=password][name=?]", "user[password_confirmation]"
    end
  end
end
