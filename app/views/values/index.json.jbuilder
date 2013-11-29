json.array!(@values) do |value|
  json.extract! value, :stamp, :value, :metric_id
  json.url value_url(value, format: :json)
end
