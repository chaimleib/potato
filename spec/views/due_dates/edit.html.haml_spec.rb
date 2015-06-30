require 'rails_helper'

RSpec.describe "due_dates/edit", type: :view do
  before(:each) do
    @due_date = assign(:due_date, DueDate.create!(
      :branch_name => "MyString",
      :target_version => "MyString",
      :due => "MyString"
    ))
  end

  it "renders the edit due_date form" do
    render

    assert_select "form[action=?][method=?]", due_date_path(@due_date), "post" do

      assert_select "input#due_date_branch_name[name=?]", "due_date[branch_name]"

      assert_select "input#due_date_target_version[name=?]", "due_date[target_version]"

      assert_select "input#due_date_due[name=?]", "due_date[due]"
    end
  end
end
