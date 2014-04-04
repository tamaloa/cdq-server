class Dimension < ActiveRecord::Base
  belongs_to :app
  has_many :metrics
  has_many :rollups

  def to_s
    name
  end

  def expectation_met?
    return true unless expectation
    current_score >= expectation
  end

  def current_score
    return 0.0 if metrics.empty?
    weighted_values =  metrics.map{|m| m.value*m.weight}
    weighted_values.sum / metrics.map(&:weight).sum
  end

  def values_for_chart
    hours_in_one_week = (24*7)
    points = rollups.where(resolution: :hour).order(:stamp).limit(hours_in_one_week)
    points.map{|r| [r.stamp.to_i*1000, r.avg]}
  end

  def last_values
    metrics.map{|m| m.values.last}
  end

end
