# frozen_string_literal: true

class RenameUsersToOrganizations < ActiveRecord::Migration[6.1]
  def change
    rename_table :users, :organizations
  end
end
