json.array!(@data_assets) do |data_asset|
  json.extract! data_asset, :id, :name, :description, :app_id
  json.url data_asset_url(data_asset, format: :json)
end
