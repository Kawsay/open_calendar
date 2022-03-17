# frozen_string_literal: true

class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.text :title
      t.string :description
      t.references :documentable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
