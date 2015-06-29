require 'rails_helper'

RSpec.describe "resource_updates/show", type: :view do
  before(:each) do
    @resource_update = assign(:resource_update, ResourceUpdate.create!(
      :name => "Name",
      :source_uri => "MyText",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
