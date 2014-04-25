class Metric < ActiveRecord::Base
  belongs_to :dimension
  has_many :values, -> { order "stamp" }
  has_many :rollups, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :dimension_id

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
    # points = []
    # hours_in_one_week.times do |number|
    #   points << [ number.hours.ago.to_i*1000, score(number.hours.ago) ]
    # end
    # points
    points = rollups.where(resolution: :hour).order(:stamp)#.limit(hours_in_one_week)
    points.map{|r| [r.stamp.to_i*1000, r.avg]}
  end

  def last_values
    values.limit(10)
  end

  def score(timestamp)
    last_valid_value = values.where('stamp <= ?', timestamp).order(:stamp).last
    return 0.0 unless last_valid_value
    last_valid_value.value
  end


end
