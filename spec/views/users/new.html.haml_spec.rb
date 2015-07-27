require 'rails_helper'

RSpec.describe "users/new", type: :view do
  before(:each) do
    assign :user, FactoryGirl.build(:user)
  end

  it "renders new user form" do
    render

    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_fname[name=?]", "user[fname]"
      assert_select "input#user_lname[name=?]", "user[lname]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_password[type=password][name=?]", "user[password]"
      assert_select "input#user_password_confirmation[type=password][name=?]", "user[password_confirmation]"
    end
  end
end
