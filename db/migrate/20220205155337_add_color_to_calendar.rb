# frozen_string_literal: true

class AddColorToCalendar < ActiveRecord::Migration[6.1]
  def change
    add_column :calendars, :background_color, :string, limit: 7
    add_column :calendars, :text_color, :string
  end
end
