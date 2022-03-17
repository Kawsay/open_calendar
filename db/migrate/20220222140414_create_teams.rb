# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams, &:timestamps

    create_table :team_members, &:timestamps

    add_reference :teams, :team_member
    add_reference :users, :team_member
    add_reference :team_members, :user, index: true, type: :uuid
    add_reference :team_members, :team, index: true

    add_index :team_members, %i[user_id team_id]
  end
end
