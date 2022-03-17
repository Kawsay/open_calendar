# frozen_string_literal: true

class RenameTeamMembersToAdhesions < ActiveRecord::Migration[6.1]
  def change
    rename_table :team_members, :adhesions
  end
end
