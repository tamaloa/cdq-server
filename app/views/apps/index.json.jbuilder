json.array!(@apps) do |app|
  json.extract! app, :name, :expectation
  json.url app_url(app, format: :json)
end
