class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments, id: :uuid do |t|
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.belongs_to :commentable, polymorphic: true, null: false, type: :uuid
      t.integer :parent_id

      t.timestamps
    end
  end
end
