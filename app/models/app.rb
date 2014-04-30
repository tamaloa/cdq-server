class App < ActiveRecord::Base
  has_many :dimensions, :dependent => :destroy
  has_many :rollups, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name

  include Calculations

  def to_s
    name
  end

  def current_score
    return 0.0 if dimensions.empty?
    weighted_values =  dimensions.map{|d| d.current_score*d.weight}
    weighted_values.sum / dimensions.map(&:weight).sum
  end

  def values_for_chart(resolution = :hour, stamp = Time.now)
    hours_in_one_week = (24*7)
    # points = []
    # hours_in_one_week.times do |number|
    #   points << [ number.hours.ago.to_i*1000, score(number.hours.ago) ]
    # end
    #
    # points

    points = rollups.where(resolution: :hour).order(:stamp)#.limit(hours_in_one_week)
    points.map{|r| [r.stamp.to_i*1000, r.avg]}

  end

  def last_values
    dimensions.map{|d| d.last_values}.flatten
  end

  def score(stamp)
    #TODO change here if dimension get weight again
    metrics = dimensions.map(&:metrics).flatten
    weighted_average metrics.select{|m| m.score(stamp)}.map{|m| {:value => m.score(stamp), :weight => m.weight} }
  end

end
