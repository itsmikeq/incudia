json.array!(@broadcasts) do |broadcast|
  json.extract! broadcast, :id, :message, :ends_at, :starts_at, :alert_type, :color, :font
  json.url broadcast_url(broadcast, format: :json)
end
