class EnsureValidData < ActiveRecord::Migration
  def change
    Dimension.all.each do |dim|
      dim.expectation = 0.5 if dim.expectation.blank?
      dim.weight = 1 if dim.weight.blank?
      dim.save
    end
    Metric.all.each do |m|
      m.weight = 1 if m.weight.blank?
      m.save
    end
  end
end
