json.array!(@broadcast_messages) do |broadcast_message|
  json.extract! broadcast_message, :id, :message, :ends_at, :starts_at, :alert_type, :color, :font
  json.url broadcast_message_url(broadcast_message, format: :json)
end
