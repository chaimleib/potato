require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    root = FactoryGirl.create :root_user
    @user = FactoryGirl.create :user
    assign :users, [
      root,
      @user
    ]
  end

  it "renders a list of users" do
    render
    assert_select "tr" do
      assert_select "th", 'First name'
      assert_select "th", 'Last name'
      assert_select "th", 'E-mail'
    end
    assert_select "tr" do
      assert_select "td", User.root_user.fname
      assert_select "td", User.root_user.lname
      assert_select "td", User.root_user.concealed_email
      assert_select "td", "Permissions"
      assert_select "td", "Root user"
    end
    assert_select "tr" do
      assert_select "td", @user.fname
      assert_select "td", @user.lname
      assert_select "td", @user.concealed_email
      assert_select "td", "Permissions"
      assert_select "td", "Root user", false
    end
  end
end
