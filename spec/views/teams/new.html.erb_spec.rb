# frozen_string_literal: true

require 'rails_helper'

describe 'teams/new.html.erb', type: :view do
  it 'display a form' do
    user = Fabricate(:user)
    team = Fabricate.build(:team, users: [user])

    assign(:team, team)

    render

    expect(rendered).to match(/form\sid="new_team"/)
  end
end
