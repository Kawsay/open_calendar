class ChangeCalendarIdFromIntegerToUuid < ActiveRecord::Migration[6.1]
  def change
    add_column :calendars, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    remove_reference :events, :calendar, index: true, foreign_key: true
    remove_reference :secret_links, :calendar, index: true, foreign_key: true

    change_table :calendars do |t|
      t.remove :id
      t.rename :uuid, :id
    end

    execute 'ALTER TABLE calendars ADD PRIMARY KEY (id);'

    add_reference :events, :calendar, index: true, foreign_key: true, type: :uuid
    add_reference :secret_links, :calendar, index: true, foreign_key: true, type: :uuid
  end
end
