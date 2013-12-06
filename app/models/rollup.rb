class Rollup < ActiveRecord::Base
  belongs_to :metric
  belongs_to :dimension
  belongs_to :app
  has_and_belongs_to_many :values

  def self.add(value)
    resolutions.each do |resolution|
      rollup = find_or_create_by(
          metric: value.metric,
          stamp: Resolution.utc_timestamp_for(resolution, value.stamp),
          resolution: resolution)
      rollup.values << value
      rollup.avg = rollup.values.average(:value)
      rollup.max = (rollup.max > value.value) ? rollup.max : value.value
      rollup.min = (rollup.min < value.value) ? rollup.min : value.value
      rollup.save
    end

  end

  def self.resolutions
    Resolution.defaults
  end

end
