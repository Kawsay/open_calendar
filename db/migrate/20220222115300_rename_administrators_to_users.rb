class RenameAdministratorsToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :administrators, :users
  end
end
