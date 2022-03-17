# frozen_string_literal: true

require 'rails_helper'

describe 'calendars/new.html.erb', type: :view do
  before(:each) do
    @user     = Fabricate(:user)
    @team     = Fabricate(:team)
    @adhesion = Fabricate(:adhesion, user: @user, team: @team)
    @calendar = Fabricate.build(:calendar)

    assign(:current_team, @team)
    assign(:new_calendar, @calendar)
  end

  it 'display a form' do
    render

    expect(rendered).to match(/form\sid="new_calendar"/)
  end

  it 'display an input tag for calendar name' do
    render

    expect(rendered).to match(/input.*name="calendar\[name\].*(?=>)/)
  end

  it 'display an input tag for calendar background color' do
    render

    expect(rendered).to match(/input.*name="calendar\[background_color\].*(?=>)/)
  end

  it 'display an hidden tag for team id' do
    render

    expect(rendered).to match(/input.*type="hidden"\sname="calendar\[team_id\].*(?=>)/)
  end

  it 'sets the team id value inside the hidden input tag' do
    render

    expect(rendered).to match(/input\svalue="#{@team.id}"\sautocomplete="off"\stype="hidden"\sname="calendar\[team_id\].*(?=>)/)
  end
end
