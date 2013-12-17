class Metric < ActiveRecord::Base
  belongs_to :dimension
  has_many :values, -> { order "stamp" }


  def to_s
    name
  end

  def record(value, stamp = Time.now)
    return false if value > 1.0
    return false if value < 0.0
    value = Value.create(value: value, stamp: stamp, metric: self)
    Rollup.add(value)
    #MetricValue.new(value: value, stamp: stamp)
    #MetricValueRollup.create_or_update(stamp)
    #DimensionValueRollup.create_or_update(stamp)
    ## for each resolution (calculated from stamp) do
    ## rollup_value refresh
    ### select all last values from resolution(stamp) for dimension
    ### calculate weighed average, min, max
    #AppValueRollup.create_or_update(stamp)
    ## see before
  end
end
