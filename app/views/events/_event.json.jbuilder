json.extract! event, :id, :name, :description, :when, :where, :url, :map_url, :created_at, :updated_at
json.url event_url(event, format: :json)
