class Rollup < ActiveRecord::Base
  belongs_to :metric
  belongs_to :dimension
  belongs_to :app
  has_and_belongs_to_many :values

  def self.add(value)
    resolutions.each do |resolution|
      stamp = Resolution.utc_timestamp_for(resolution, value.stamp)

      rollup_metric = find_or_create_by(metric: value.metric, stamp: stamp, resolution: resolution)
      rollup_metric.add_value_and_recalculate(value)

      rollup_dimension = find_or_create_by(dimension: value.metric.dimension, stamp: stamp, resolution: resolution)
      rollup_dimension.add_value_and_recalculate(value)

      rollup_app = find_or_create_by(app: value.metric.dimension.app, stamp: stamp, resolution: resolution)
      rollup_app.add_value_and_recalculate(value)
    end

  end

  def self.resolutions
    Resolution.defaults
  end

  def add_value_and_recalculate(value)
    values << value
    self.avg = values.average(:value)
    self.max = (max > value.value) ? max : value.value
    self.min = (min < value.value) ? min : value.value
    save
  end

end
