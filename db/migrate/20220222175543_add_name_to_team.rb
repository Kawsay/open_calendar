class AddNameToTeam < ActiveRecord::Migration[6.1]
  def change
    add_column :teams, :name, :string, null: false, uniq: true
  end
end
