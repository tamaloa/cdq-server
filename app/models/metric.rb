class Metric < ActiveRecord::Base
  belongs_to :dimension
  has_many :values, -> { order 'stamp ASC' }
  has_many :rollups, dependent: :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :dimension_id

  include Charting
  include Rollups

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

  def expectation_met?(stamp = Time.now)
    return false unless dimension
    return true unless dimension.expectation
    score = rollup_score(stamp)
    return true unless score
    score >= dimension.expectation
  end

  def recent_values(timestamp = Time.now)
    values.where('stamp <= ?', timestamp).reorder('stamp DESC').limit(10)
  end

  def score(timestamp)
    last_valid_value = values.where('stamp <= ?', timestamp).order(:stamp).last
    return nil unless last_valid_value
    days_until_metric_vanishes = (Figaro.env.days_until_metric_vanishes || 14).to_i.days
    return nil if last_valid_value.stamp <= timestamp - days_until_metric_vanishes
    last_valid_value.value
  end


end
