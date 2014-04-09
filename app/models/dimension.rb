class Dimension < ActiveRecord::Base
  belongs_to :app
  has_many :metrics, :dependent => :destroy
  has_many :rollups, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :app_id
  validates_numericality_of :weight, :expectation

  include Calculations

  def to_s
    name
  end

  def expectation_met?
    return true unless expectation
    current_score >= expectation
  end

  def current_score
    return 0.0 if metrics.empty?
    weighted_average metrics.map{|m| {:value => m.current_value, :weight => m.weight} }
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
    metrics.map{|m| m.values.last}
  end

  def score(stamp)
    weighted_average metrics.map{|m| {:value => m.score(stamp), :weight => m.weight} }
  end


end
