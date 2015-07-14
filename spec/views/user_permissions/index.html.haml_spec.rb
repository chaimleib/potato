require 'rails_helper'

RSpec.describe "user_permissions/index", type: :view do
  before(:each) do
    assign(:user_permissions, [
      UserPermission.create!(
        :user => nil,
        :is_admin => ""
      ),
      UserPermission.create!(
        :user => nil,
        :is_admin => ""
      )
    ])
  end

  it "renders a list of user_permissions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
