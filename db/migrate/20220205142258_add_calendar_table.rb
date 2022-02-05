class AddCalendarTable < ActiveRecord::Migration[6.1]
  def change
    create_table :calendars do |t|
      t.string :name, null: false, uniq: true
      t.index  :name

      t.timestamps
    end
  end
end
