class AddIndexesOnRollups < ActiveRecord::Migration
  def change
    add_index :rollups, [:app_id, :resolution, :stamp]
    add_index :rollups, [:dimension_id, :resolution, :stamp]
    add_index :rollups, [:metric_id, :resolution, :stamp]
  end
end
