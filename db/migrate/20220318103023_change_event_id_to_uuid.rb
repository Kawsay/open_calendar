class ChangeEventIdToUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :events do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute "ALTER TABLE events ADD PRIMARY KEY (id);"
  end
end
