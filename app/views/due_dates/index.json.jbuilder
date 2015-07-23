json.array!(@due_dates) do |due_date|
  json.extract! due_date, :id, :branch_name, :resolve, :due, :due_ref_id
  json.due_ref due_date.due_ref.present? ? due_date.due_ref.branch_name : nil
  json.due_ref_url due_date.due_ref.present? ? due_date_url(due_date.due_ref, format: :json) : nil
  json.url due_date_url(due_date, format: :json)
end
