class AddPseudonymToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :pseudonym, :string, limit: 64
    add_index :users, :pseudonym
  end
end
