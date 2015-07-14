require 'rails_helper'

RSpec.describe "potato/overview.html.haml", type: :view do

  it 'renders successfully' do
    context = {
      user: Rails.application.secrets.jira['username'],
      errors: {}
    }
    assign :context, context
    
    render

    expect(rendered).to match %r{<table [^>]*data-url=['"]/potato/overview\?utf8=%E2%9C%93&amp}
    # is_expected.to render('potato/overview.html.haml')
  end
end
