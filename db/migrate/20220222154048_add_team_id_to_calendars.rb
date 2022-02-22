class AddTeamIdToCalendars < ActiveRecord::Migration[6.1]
  def change
    add_reference :calendars, :team, null: false, foreign_key: true
  end
end
