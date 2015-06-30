json.array!(@due_dates) do |due_date|
  json.extract! due_date, :id, :branch_name, :target_version, :due
  json.url due_date_url(due_date, format: :json)
end
