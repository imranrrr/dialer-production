json.extract! user, :id, :phone, :phone1, :phone2, :fio, :rank, :role, :group, :pincode, :created_at, :updated_at
json.url user_url(user, format: :json)
