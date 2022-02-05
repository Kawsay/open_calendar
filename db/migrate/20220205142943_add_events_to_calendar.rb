class AddEventsToCalendar < ActiveRecord::Migration[6.1]
  def change
    add_reference :events, :calendar, null: false, foreign_key: true
  end
end
