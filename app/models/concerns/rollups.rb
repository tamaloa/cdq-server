module Rollups
  extend ActiveSupport::Concern

  def rollup_score(stamp)
    rollup = rollups.where(resolution: :hour).where('stamp <= ?', stamp).order(:stamp).last
    return nil unless rollup
    rollup.avg
  end

end