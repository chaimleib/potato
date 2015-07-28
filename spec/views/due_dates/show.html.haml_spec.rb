require 'rails_helper'

RSpec.describe "due_dates/show", type: :view do
  before(:each) do
    @due_date = assign :due_date, FactoryGirl.create(:due_date)
  end

  it "renders attributes in a table" do
    render
    assert_select "tr" do
      assert_select "th", "Branch name:"
      assert_select "td", @due_date.branch_name
    end
    assert_select "tr" do
      assert_select "th", "Due:"
      assert_select "td", @due_date.due
    end
  end
end
