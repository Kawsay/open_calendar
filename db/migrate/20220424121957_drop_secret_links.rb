class DropSecretLinks < ActiveRecord::Migration[6.1]
  def change
    drop_table :secret_links
  end
end
