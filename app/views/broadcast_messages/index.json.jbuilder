json.array!(@broadcast_messages) do |broadcast_message|
  json.extract! broadcast_message, :id, :message, :expire_in, :start_at
  json.url broadcast_message_url(broadcast_message, format: :json)
end
