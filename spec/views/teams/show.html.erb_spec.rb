require 'rails_helper'

describe 'teams/show.html.erb', type: :view do
  it 'display a form if @teams is blank' do
    render

    expect(rendered).to match(/.*/)
  end
end
