class DataAssetsMetricsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :data_assets, :metrics do |t|
      t.index :data_asset_id
      t.index :metric_id
    end
  end
end
