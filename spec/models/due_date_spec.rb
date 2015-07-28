require 'rails_helper'

RSpec.describe DueDate, type: :model do
  it "is valid from the factory" do
    dd = FactoryGirl.create :due_date
    
    expect(dd.branch_name).to be_present
    expect(dd.resolve).to be_present
    expect(dd.due_ref).to be_nil
    expect(dd.due).to be_present

    lookup_time = DueDate.for_version dd.branch_name
    lookup_str = lookup_time.strftime '%m/%d/%Y'
    expect(dd.resolve).to eq(lookup_str)

  end
  it "is valid from the factory (with due_ref)" do
    dd = FactoryGirl.create :due_date
    rdd = FactoryGirl.create :ref_due_date, due_ref: dd

    expect(rdd.branch_name).to be_present
    expect(rdd.resolve).to be_present
    expect(rdd.due_ref).to be_present
    expect(rdd.due).to_not be_present

    lookup_time = DueDate.for_version rdd.branch_name
    lookup_str = lookup_time.strftime '%m/%d/%Y'
    expect(rdd.resolve).to eq(lookup_str)
  end

end
