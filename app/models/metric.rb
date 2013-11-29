class Metric < ActiveRecord::Base
  belongs_to :dimension
  has_many :values

  def to_s
    name
  end

  def record(value, stamp = Time.now)
    MetricValue.new(value: value, stamp: stamp)
    MetricValueRollup.create_or_update(stamp)
    DimensionValueRollup.create_or_update(stamp)
    # for each resolution (calculated from stamp) do
    # rollup_value refresh
    ## select all last values from resolution(stamp) for dimension
    ## calculate weighed average, min, max
    AppValueRollup.create_or_update(stamp)
    # see before
  end
end
