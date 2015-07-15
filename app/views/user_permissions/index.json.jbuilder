json.array!(@user_permissions) do |user_permission|
  json.extract! user_permission, :id, :user_id, :is_admin
  json.url user_permission_url(user_permission, format: :json)

  json.user do
    user = user_permission.user
    json.id user.id
    json.fname user.fname
    json.lname user.lname
    json.is_admin? user.is_admin?
    json.is_root? user.is_root?
    json.url user_url(user, format: :json)
  end
end

