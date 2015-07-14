json.array!(@user_permissions) do |user_permission|
  json.extract! user_permission, :id, :user_id, :is_admin
  json.url user_permission_url(user_permission, format: :json)
end
