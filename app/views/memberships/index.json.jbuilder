json.array!(@memberships) do |membership|
  json.extract! membership, :id, :member_id, :of_id, :of_type
  json.url membership_url(membership, format: :json)
end
