json.array!(@users) do |user|
  json.extract! user, :id, :fname, :lname#, :email
  json.url user_url(user, format: :json)
  json.user_permission do
    perm = user.ensure_permission
    json.id perm.id
    json.url user_permission_url(perm)
  end
end
