class Resolution

  def self.defaults
    [:hour, :day, :month, :year]
  end

  def self.utc_timestamp_for(resolution, stamp = Time.now)
    Time.utc(stamp.year, stamp.month, stamp.day, stamp.hour) if resolution.to_sym.eql?(:hour)
    Time.utc(stamp.year, stamp.month, stamp.day) if resolution.to_sym.eql?(:day)
    Time.utc(stamp.year, stamp.month) if resolution.to_sym.eql?(:month)
    Time.utc(stamp.year) if resolution.to_sym.eql?(:year)

    raise ResolutionException
  end

end
