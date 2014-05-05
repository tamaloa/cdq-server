module Charting
  extend ActiveSupport::Concern

  def values_for_chart(filter = {})
    resolution = filter[:resolution] || :day
    time_till = filter[:time_till] || Time.now
    time_from = filter[:time_from] || Time.now - 5.years

    points = rollups.where(resolution: resolution).where('stamp <= ?', time_till).where('stamp >= ?', time_from).order(:stamp)
    points.map{|r| [r.stamp.to_i*1000, r.avg]}
  end

end