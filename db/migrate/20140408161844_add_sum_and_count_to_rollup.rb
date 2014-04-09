class AddSumAndCountToRollup < ActiveRecord::Migration
  def change
    add_column :rollups, :sum, :float, :default => 0.0
    add_column :rollups, :count, :integer, :default => 0
  end
end
