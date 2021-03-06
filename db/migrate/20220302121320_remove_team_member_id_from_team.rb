# frozen_string_literal: true

class RemoveTeamMemberIdFromTeam < ActiveRecord::Migration[6.1]
  def change
    remove_index  :teams, name: 'index_teams_on_team_member_id', column: :team_member_id
    remove_column :teams, :team_member_id, :integer
  end
end
