class AddTeamIdToCalendars < ActiveRecord::Migration[6.1]
  def change
    if Calendar.any? && Team.any?
      add_reference :calendars, :team, foreign_key: true, null: false, default: Team.first.id
    else
      add_reference :calendars, :team, foreign_key: true, null: false
    end
  end
end
