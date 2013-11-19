json.array!(@dimensions) do |dimension|
  json.extract! dimension, :name, :description, :expectation, :weight, :app_id
  json.url dimension_url(dimension, format: :json)
end
