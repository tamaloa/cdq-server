class Dimension < ActiveRecord::Base
  belongs_to :app
  has_many :metrics, :dependent => :destroy
  has_many :rollups, :dependent => :destroy

  has_many :subjective_assessments, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => :app_id
  validates_numericality_of :weight, :expectation

  include Calculations
  include Charting
  include Rollups


  after_initialize :set_description

  def to_s
    name
  end

  def expectation_met?(stamp = Time.now)
    return true unless expectation
    score = rollup_score(stamp)
    return true unless score
    score >= expectation
  end

  def current_score
    return 0.0 if metrics.empty?
    weighted_average metrics.map{|m| {:value => m.current_value, :weight => m.weight} }
  end

  def last_values
    metrics.map{|m| m.values.last}
  end

  def score(stamp)
    weighted_average metrics.select{|m| m.score(stamp)}.map{|m| {:value => m.score(stamp), :weight => m.weight} }
  end

  private

  def set_description
    return if name.blank?
    return unless DefaultDimension.find(name)
    self.description = DefaultDimension.find(name).description if description.blank?
  end


end
