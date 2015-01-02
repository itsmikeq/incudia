json.array!(@notifications) do |notification|
  json.extract! notification, :id, :type, :message, :from_id, :from_type, :to_id, :to_type
  json.url notification_url(notification, format: :json)
end
