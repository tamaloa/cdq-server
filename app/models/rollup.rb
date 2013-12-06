class Rollup < ActiveRecord::Base
  belongs_to :metric
  belongs_to :dimension
  belongs_to :app
  has_and_belongs_to_many :values

  def self.add(value)
    resolutions.each do |resolution|
      rollup = new(metric: value.metric, stamp: value.stamp, avg: value.value, resolution: resolution)
      rollup.values << value
      rollup.save
    end

  end

  def self.resolutions
    Resolution.defaults
  end

end
