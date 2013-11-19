json.array!(@metrics) do |metric|
  json.extract! metric, :name, :description, :expectation, :weight, :dimension_id
  json.url metric_url(metric, format: :json)
end
