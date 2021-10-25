json.extract! document, :id, :title, :description, :file, :documentable_id, :documentable_type, :created_at, :updated_at
json.url document_url(document, format: :json)
json.file url_for(document.file)
