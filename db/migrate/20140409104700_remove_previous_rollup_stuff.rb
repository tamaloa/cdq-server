class RemovePreviousRollupStuff < ActiveRecord::Migration
  def change
    Rollup.delete_all
    drop_table :rollups_values
  end
end
