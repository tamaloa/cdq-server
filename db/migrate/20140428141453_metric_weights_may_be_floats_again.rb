class MetricWeightsMayBeFloatsAgain < ActiveRecord::Migration
  def change
    change_column :metrics, :weight, :float, :default => 1.0
  end
end
