class DataAsset < ActiveRecord::Base
  belongs_to :app
  has_and_belongs_to_many :metrics
  has_many :rollups, :dependent => :destroy

  include Calculations
  include Charting
  include Rollups

  def score(stamp)
    average metrics.map{|metric| metric.score(stamp)}
  end

  def current_score
    return 0.0 if metrics.empty?
    average metrics.map{|metric| metric.current_value}
  end

  #Some stuff to make it quack like a Dimension
  def expectation_met?(*args)
    true
  end
  def expectation
    0.5
  end

end
