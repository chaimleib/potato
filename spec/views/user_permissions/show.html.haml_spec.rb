require 'rails_helper'

RSpec.describe "user_permissions/show", type: :view do
  before(:each) do
    @user_permission = assign(:user_permission, UserPermission.create!(
      :user => nil,
      :is_admin => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
