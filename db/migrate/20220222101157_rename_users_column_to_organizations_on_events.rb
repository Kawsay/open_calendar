class RenameUsersColumnToOrganizationsOnEvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :user_id, :organization_id
  end
end
