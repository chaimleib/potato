require 'rails_helper'

RSpec.describe "due_dates/index", type: :view do
  before(:each) do

    assign :due_dates, [
      (@dd = FactoryGirl.create(:due_date)),
      (@rdd = FactoryGirl.create(:ref_due_date, due_ref: @dd))
    ]
  end

  it "renders a list of due_dates" do
    render
    assert_select "tr" do
      assert_select "th", "Branch name"
      assert_select "th", "Due"
      assert_select "th", "", 3
    end
    assert_select "tr" do
      assert_select "td", @dd.branch_name
      assert_select "td", @dd.due
      assert_select "td>a", "Show"
      assert_select "td>a", "Edit"
      assert_select "td>a", "Destroy"
    end
    assert_select "tr" do
      assert_select "td", @rdd.branch_name
      assert_select "td", /\A#{Regexp.escape @dd.branch_name}/
      assert_select "td>a", "Show"
      assert_select "td>a", "Edit"
      assert_select "td>a", "Destroy"
    end
  end
end
