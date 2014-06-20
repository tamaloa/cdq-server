class HistoricAssessmentHelper

  def self.regenerate_rollups_for_apps(apps = [])
    timestamps = []
    timestamps << Date.new(2012, 5).to_time_in_current_zone
    timestamps << Date.new(2012, 9).to_time_in_current_zone
    timestamps << Date.new(2013, 1).to_time_in_current_zone
    timestamps << Date.new(2013, 5).to_time_in_current_zone
    timestamps << Date.new(2013, 9).to_time_in_current_zone
    timestamps << Date.new(2014, 1).to_time_in_current_zone
    timestamps << Date.new(2014, 5).to_time_in_current_zone

    from = Date.new(2014, 5).to_time_in_current_zone
    now = Time.now
    until from >= now do
      from = from + 1.hour
      timestamps << from
    end
    ### either above or this:
    #timestamps << Date.new(2014, 6).to_time_in_current_zone

    dimensions = Dimension.where(app_id: apps)
    metrics = Metric.where(dimension_id: dimensions)

    #Remove old Rollups
    app.each{|a| a.rollups.delete_all}
    dimensions.each{|d| d.rollups.delete_all}
    metrics.each{|m| m.rollups.delete_all}

    timestamps.each do |timestamp|
      Resolution.defaults.each do |resolution|
        resolution_stamp = Resolution.utc_timestamp_for(resolution, timestamp)


        metrics.each do |metric|
          score = metric.score(timestamp)
          next unless score
          rollup_metric = Rollup.find_or_create_by(metric: metric, stamp: resolution_stamp, resolution: resolution)
          rollup_metric.add_score_and_recalculate(score)
        end

        dimensions.each do |dimension|
          score = dimension.score(timestamp)
          next unless score
          rollup_dimension = Rollup.find_or_create_by(dimension: dimension, stamp: resolution_stamp, resolution: resolution)
          rollup_dimension.add_score_and_recalculate(score)
        end

        apps.each do |app|
          score = app.score(timestamp)
          next unless score
          rollup_app = Rollup.find_or_create_by(app: app, stamp: resolution_stamp, resolution: resolution)
          rollup_app.add_score_and_recalculate(score)
        end

      end
    end
  end

  def self.prepare_dqf
    Rollup.calculate(Date.new(2012, 5).to_time_in_current_zone)
    Rollup.calculate(Date.new(2012, 9).to_time_in_current_zone)
    Rollup.calculate(Date.new(2013, 1).to_time_in_current_zone)
    Rollup.calculate(Date.new(2013, 5).to_time_in_current_zone)
    Rollup.calculate(Date.new(2013, 9).to_time_in_current_zone)
    Rollup.calculate(Date.new(2014, 1).to_time_in_current_zone)
    Rollup.calculate(Date.new(2014, 5).to_time_in_current_zone)

    from = Date.new(2014, 5).to_time_in_current_zone
    now = Time.now
    until from >= now do
      from = from + 1.hour
      Rollup.calculate(from)
    end
  end
end