class AddNewDefaultExpectationToDimension < ActiveRecord::Migration
  def change
    change_column :dimensions, :expectation, :float, :default => 0.5
  end
end
