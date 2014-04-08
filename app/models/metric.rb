class Metric < ActiveRecord::Base
  belongs_to :dimension
  has_many :values, -> { order "stamp" }
  has_many :rollups


  def to_s
    name
  end

  def record(value, stamp = Time.now)
    return false if value > 1.0
    return false if value < 0.0
    value = Value.create(value: value, stamp: stamp, metric: self)
    value
  end

  def current_value
    return 0.0 unless values.last
    values.last.value
  end

  def expectation_met?
    return false unless dimension
    return true unless dimension.expectation
    current_value >= dimension.expectation
  end

  def values_for_chart
    hours_in_one_week = (24*7)
    points = rollups.where(resolution: :hour).order(:stamp).limit(hours_in_one_week)
    points.map{|r| [r.stamp.to_i*1000, r.avg]}
  end

  def last_values
    values.limit(10)
  end


end
