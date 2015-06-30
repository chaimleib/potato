require 'rails_helper'

RSpec.describe "due_dates/show", type: :view do
  before(:each) do
    @due_date = assign(:due_date, DueDate.create!(
      :branch_name => "Branch Name",
      :target_version => "Target Version",
      :due => "Due"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Branch Name/)
    expect(rendered).to match(/Target Version/)
    expect(rendered).to match(/Due/)
  end
end
