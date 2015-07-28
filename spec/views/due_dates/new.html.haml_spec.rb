require 'rails_helper'

RSpec.describe "due_dates/new", type: :view do
  before(:each) do
    assign :due_date, DueDate.new
  end

  it "renders new due_date form" do
    render

    assert_select "form[action=?][method=?]", due_dates_path, "post" do
      assert_select "input#due_date_branch_name[name=?]", "due_date[branch_name]"
      assert_select "input#due_date_due[name=?]", "due_date[due]"
      assert_select "select#due_date_due_ref_id[name=?]", "due_date[due_ref_id]"
    end
  end
end
