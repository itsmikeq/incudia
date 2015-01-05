json.array!(@focalpoints_users) do |focalpoints_user|
  json.extract! focalpoints_user, :id, :user_id, :focalpoint_id, :access_level
  json.url focalpoints_user_url(focalpoints_user, format: :json)
end
