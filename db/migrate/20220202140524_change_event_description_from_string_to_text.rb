# frozen_string_literal: true

class ChangeEventDescriptionFromStringToText < ActiveRecord::Migration[6.1]
  def change
    change_column :events, :description, :text
  end
end
