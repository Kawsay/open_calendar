class ChangePgSearchSearchableIdTypeFromIntToUuid < ActiveRecord::Migration[6.1]
  def up
    remove_reference :pg_search_documents, :searchable, polymorphic: true, index: true
    add_reference :pg_search_documents, :searchable, polymorphic: true, index: true, type: :uuid
  end

  def down
    remove_reference :pg_search_documents, :searchable, polymorphic: true, index: true, type: :uuid
    add_reference :pg_search_documents, :searchable, polymorphic: true, index: true
  end
end
