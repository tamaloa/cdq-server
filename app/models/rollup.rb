class Rollup < ActiveRecord::Base
  belongs_to :metric
  belongs_to :dimension
  belongs_to :data_asset
  belongs_to :app

  def self.calculate(timestamp = Time.now)
    resolutions.each do |resolution|
      resolution_stamp = Resolution.utc_timestamp_for(resolution, timestamp)

      [Metric, Dimension, DataAsset, App].each do |rollupable_klass|
        rollupable_klass.find_each do |rollupable|
          score = rollupable.score(timestamp)
          next unless score
          rollup_metric = rollupable.rollups.find_or_create_by(stamp: resolution_stamp, resolution: resolution)
          rollup_metric.add_score_and_recalculate(score)
        end
      end

    end
  end

  def self.resolutions
    Resolution.defaults
  end

  def add_score_and_recalculate(score)
    return false unless score
    return false if score > 1.0
    return false if score < 0.0
    self.count += 1
    self.sum += score
    self.avg = sum / count
    self.max = (max > score) ? max : score
    self.min = (min < score) ? min : score
    save
  end

end
