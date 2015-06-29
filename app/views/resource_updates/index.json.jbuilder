json.array!(@resource_updates) do |resource_update|
  json.extract! resource_update, :id, :name, :updated, :source_uri, :user_id
  json.url resource_update_url(resource_update, format: :json)
end
