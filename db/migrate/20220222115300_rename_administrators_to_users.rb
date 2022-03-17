# frozen_string_literal: true

class RenameAdministratorsToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :administrators, :users
  end
end
