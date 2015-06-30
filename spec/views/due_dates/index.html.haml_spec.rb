require 'rails_helper'

RSpec.describe "due_dates/index", type: :view do
  before(:each) do
    assign(:due_dates, [
      DueDate.create!(
        :branch_name => "Branch Name",
        :target_version => "Target Version",
        :due => "Due"
      ),
      DueDate.create!(
        :branch_name => "Branch Name",
        :target_version => "Target Version",
        :due => "Due"
      )
    ])
  end

  it "renders a list of due_dates" do
    render
    assert_select "tr>td", :text => "Branch Name".to_s, :count => 2
    assert_select "tr>td", :text => "Target Version".to_s, :count => 2
    assert_select "tr>td", :text => "Due".to_s, :count => 2
  end
end
