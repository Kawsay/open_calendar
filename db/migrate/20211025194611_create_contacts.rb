class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.text :mobile, limit: 12
      t.text :email
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
