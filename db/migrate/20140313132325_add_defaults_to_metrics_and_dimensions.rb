class AddDefaultsToMetricsAndDimensions < ActiveRecord::Migration
  def change
    change_column :metrics, :weight, :float, :default => 1.0
    change_column :dimensions, :expectation, :float, :default => 0.0
  end
end
