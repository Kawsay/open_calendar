class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.timestamps
    end

    create_table :team_members do |t|
      t.timestamps
    end

    add_reference :teams, :team_member
    add_reference :users, :team_member
    add_reference :team_members, :user, index: true, type: :uuid
    add_reference :team_members, :team, index: true

    add_index :team_members, [:user_id, :team_id]
  end
end
