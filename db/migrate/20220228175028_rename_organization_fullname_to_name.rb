class RenameOrganizationFullnameToName < ActiveRecord::Migration[6.1]
  def change
    rename_column :organizations, :fullname, :name
  end
end
