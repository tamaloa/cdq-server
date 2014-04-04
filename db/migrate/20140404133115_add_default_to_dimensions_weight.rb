class AddDefaultToDimensionsWeight < ActiveRecord::Migration
  def change
    change_column :dimensions, :weight, :float, :default => 1.0
    Dimension.all.each do |dimension|
      dimension.weight = 1.0 if dimension.weight.blank?
    end
  end
end
