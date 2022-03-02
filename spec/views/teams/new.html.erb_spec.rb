require 'rails_helper'

describe 'teams/new.html.erb', type: :view do
  it 'display a form' do
    user     = Fabricate(:user)
    adhesion = Fabricate.build(:adhesion, user: user)
    team     = Fabricate.build(:team, team_member_id: adhesion.user.id)

    assign(:team, team)

    render

    expect(rendered).to match(/form\sid=\"new_team\"/)
  end
end
