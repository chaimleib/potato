require 'rails_helper'

RSpec.describe "due_dates/new", type: :view do
  before(:each) do
    assign(:due_date, DueDate.new(
      :branch_name => "MyString",
      :target_version => "MyString",
      :due => "MyString"
    ))
  end

  it "renders new due_date form" do
    render

    assert_select "form[action=?][method=?]", due_dates_path, "post" do

      assert_select "input#due_date_branch_name[name=?]", "due_date[branch_name]"

      assert_select "input#due_date_target_version[name=?]", "due_date[target_version]"

      assert_select "input#due_date_due[name=?]", "due_date[due]"
    end
  end
end
