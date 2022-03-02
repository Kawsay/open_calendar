class RemoveTeamMemberIdFromTeam < ActiveRecord::Migration[6.1]
  def change
    remove_index  :teams, name: "index_teams_on_team_member_id"
    remove_column :teams, :team_member_id
  end
end
