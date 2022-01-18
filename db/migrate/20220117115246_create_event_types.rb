class CreateEventTypes < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        create_table :event_types do |t|
          t.string :name, null: false
          t.string :background_color, limit: 7, null: false
          t.integer :text_color, null: false, default: 0

          t.timestamps
        end

        EventType.create!(
          name: 'default',
          background_color: '#94B9B9',
          text_color: 0
        )
      end

      dir.down do
        remove_table :event_types
      end
    end
  end
end
