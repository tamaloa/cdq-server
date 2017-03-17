class AddRollupsToDataAssets < ActiveRecord::Migration
  def change
    add_belongs_to :rollups, :data_asset, index: true
    add_index :rollups, [:data_asset_id, :resolution, :stamp]
  end
end
