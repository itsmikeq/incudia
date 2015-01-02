json.array!(@focals) do |focal|
  json.extract! focal, :id, :area_id, :area_type, :name, :description, :owner_id, :owner_type, :visibility_level
  json.url focal_url(focal, format: :json)
end
