require 'rails_helper'

RSpec.describe "resource_updates/edit", type: :view do
  before(:each) do
    @resource_update = FactoryGirl.build :resource_update
    @resource_update.save
  end

  it "renders the edit resource_update form" do
    render

    assert_select "form[action=?][method=?]", resource_update_path(@resource_update), "post" do
      assert_select "input#resource_update_name[name=?]", "resource_update[name]"
      assert_select "textarea#resource_update_source_uri[name=?]", "resource_update[source_uri]"
      assert_select "input#resource_update_user_id[name=?]", "resource_update[user_id]"
    end
  end
end
