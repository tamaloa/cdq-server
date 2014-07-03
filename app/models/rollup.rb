class Rollup < ActiveRecord::Base
  belongs_to :metric
  belongs_to :dimension
  belongs_to :app

  def self.calculate(timestamp = Time.now)
    resolutions.each do |resolution|
      resolution_stamp = Resolution.utc_timestamp_for(resolution, timestamp)

      Metric.all.each do |metric|
        score = metric.score(timestamp)
        next unless score
        rollup_metric = find_or_create_by(metric: metric, stamp: resolution_stamp, resolution: resolution)
        rollup_metric.add_score_and_recalculate(score)
      end

      Dimension.all.each do |dimension|
        score = dimension.score(timestamp)
        next unless score
        rollup_dimension = find_or_create_by(dimension: dimension, stamp: resolution_stamp, resolution: resolution)
        rollup_dimension.add_score_and_recalculate(score)
      end

      App.all.each do |app|
        score = app.score(timestamp)
        next unless score
        rollup_app = find_or_create_by(app: app, stamp: resolution_stamp, resolution: resolution)
        rollup_app.add_score_and_recalculate(score)
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
