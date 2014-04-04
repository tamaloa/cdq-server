class App < ActiveRecord::Base
  has_many :dimensions
  has_many :rollups

  def to_s
    name
  end

  def current_score
    return 0.0 if dimensions.empty?
    weighted_values =  dimensions.map{|d| d.current_score*d.weight}
    weighted_values.sum / dimensions.map(&:weight).sum
  end

  def values_for_chart
    hours_in_one_week = (24*7)
    points = rollups.where(resolution: :hour).order(:stamp).limit(hours_in_one_week)
    points.map{|r| [r.stamp.to_i*1000, r.avg]}
  end

  def last_values
    dimensions.map{|d| d.last_values}.flatten
  end
end
