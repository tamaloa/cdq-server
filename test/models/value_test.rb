require 'test_helper'

class ValueTest < ActiveSupport::TestCase

  test "Value should always store time as UTC" do
    weird_time = Time.use_zone(ActiveSupport::TimeZone.new('Hawaii')){Time.zone.now}
    value = Value.create!(value: 0.32, stamp: weird_time, metric: Metric.first)
    assert_equal weird_time.utc.to_s, value.reload.stamp.to_s
  end

end
