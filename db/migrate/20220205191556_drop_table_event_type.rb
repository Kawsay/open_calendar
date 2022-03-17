# frozen_string_literal: true

class DropTableEventType < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :events, :event_types
    remove_column :events, :event_type_id

    drop_table :event_types
  end
end
