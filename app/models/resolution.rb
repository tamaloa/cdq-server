class Resolution

  def self.defaults
    [:hour, :day, :week, :month, :year]
  end

  def self.utc_timestamp_for(resolution, stamp = Time.now)
    return Time.utc(stamp.year, stamp.month, stamp.day, stamp.hour) if resolution.to_sym.eql?(:hour)
    return Time.utc(stamp.year, stamp.month, stamp.day) if resolution.to_sym.eql?(:day)
    return Time.utc(stamp.year, stamp.month, stamp.day).beginning_of_week if resolution.to_sym.eql?(:week)
    return Time.utc(stamp.year, stamp.month) if resolution.to_sym.eql?(:month)
    return Time.utc(stamp.year) if resolution.to_sym.eql?(:year)

    raise ResolutionException
  end

end
