class ChangeTeamIdFromIntegerToUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    remove_reference :calendars, :team, index: true, foreign_key: true

    change_table :teams do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute 'ALTER TABLE teams ADD PRIMARY KEY (id);'

    add_reference :calendars, :team, index: true, foreign_key: true, type: :uuid
  end
end
