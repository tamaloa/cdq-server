class Dimension < ActiveRecord::Base
  belongs_to :app
  has_many :metrics

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
end
