require 'rails_helper'

RSpec.describe "users/show", type: :view do
  before(:each) do
    @user = assign :user, FactoryGirl.create(:user)
  end

  it "renders attributes in table" do
    render
    assert_select "tr" do
      assert_select "th", "First name:"
      assert_select "td", @user.fname
    end
    assert_select "tr" do
      assert_select "th", "Last name:"
      assert_select "td", @user.lname
    end
    assert_select "tr" do
      assert_select "th", "E-mail:"
      assert_select "td", @user.email
    end
    assert_select "tr" do
      assert_select "td[colspan=2]>a[href=?]", "Permissions", user_permissions_path(@user.user_permission)
    end
  end
end
