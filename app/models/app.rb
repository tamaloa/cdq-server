class App < ActiveRecord::Base
  has_many :dimensions, :dependent => :destroy
  has_many :rollups, :dependent => :destroy
  has_many :subjective_assessment_surveys, :dependent => :destroy
  has_many :notifications

  validates_presence_of :name
  validates_uniqueness_of :name

  include Calculations
  include Charting
  include Rollups

  def to_s
    name
  end

  def current_score
    return 0.0 if dimensions.empty?
    weighted_values =  dimensions.map{|d| d.current_score*d.weight}
    weighted_values.sum / dimensions.map(&:weight).sum
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
