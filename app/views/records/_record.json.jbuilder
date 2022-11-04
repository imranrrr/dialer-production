json.extract! record, :id, :sound_url, :description, :created_at, :updated_at
json.url record_url(record, format: :json)
