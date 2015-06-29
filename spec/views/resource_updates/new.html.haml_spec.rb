require 'rails_helper'

RSpec.describe "resource_updates/new", type: :view do
  before(:each) do
    assign(:resource_update, ResourceUpdate.new(
      :name => "MyString",
      :source_uri => "MyText",
      :user => nil
    ))
  end

  it "renders new resource_update form" do
    render

    assert_select "form[action=?][method=?]", resource_updates_path, "post" do

      assert_select "input#resource_update_name[name=?]", "resource_update[name]"

      assert_select "textarea#resource_update_source_uri[name=?]", "resource_update[source_uri]"

      assert_select "input#resource_update_user_id[name=?]", "resource_update[user_id]"
    end
  end
end
