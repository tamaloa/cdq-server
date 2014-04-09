class WeightsAreSupposedToBeIntegers < ActiveRecord::Migration
  def change
    change_column :dimensions, :weight, :integer, :default => 1
    change_column :metrics, :weight, :integer, :default => 1
  end
end
