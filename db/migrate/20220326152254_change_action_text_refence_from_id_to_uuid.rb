class ChangeActionTextRefenceFromIdToUuid < ActiveRecord::Migration[6.1]
  def change
    remove_index :action_text_rich_texts, [:record_type, :record_id, :name], name: 'index_action_text_rich_texts_uniqueness', unique: true
    remove_reference :action_text_rich_texts, :record, null: false, polymorphic: true, index: false

    add_reference :action_text_rich_texts, :record, null: false, polymorphic: true, index: false, type: :uuid
    add_index :action_text_rich_texts, [:record_type, :record_id, :name], name: 'index_action_text_rich_texts_uniqueness', unique: true
  end
end
