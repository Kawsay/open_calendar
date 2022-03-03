class CreateSecretLinksTable < ActiveRecord::Migration[6.1]
  def change
    create_table :secret_links_tables do |t|
      t.string :slug, limit: 16, null: false, default: SecureRandom.alphanumeric
      t.integer :validity_period, null: false, default: 1
      t.integer :visit_count, null: false, default: 0
      t.references :calendar, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
