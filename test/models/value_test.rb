require 'test_helper'

class ValueTest < ActiveSupport::TestCase

  test "Value should always store time as UTC" do
    weird_time = Time.use_zone(ActiveSupport::TimeZone.new('Hawaii')){Time.zone.now}
    value = Value.create(value: 0.32, stamp: weird_time )
    value.reload.stamp.eql?(weird_time.utc)
  end

end
