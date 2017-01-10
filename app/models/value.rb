class Value < ActiveRecord::Base
  belongs_to :metric

  validates_presence_of :metric, :value
  validates_numericality_of :value, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0

  attr_accessor :improvement_advice

  after_commit :save_advice, on: :create

  private
  def save_advice
    metric.update(improvement_advice: self.improvement_advice)
  end
end
