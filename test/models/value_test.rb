require 'test_helper'

class ValueTest < ActiveSupport::TestCase

  test "Value should always store time as UTC" do
    weird_time = Time.use_zone(ActiveSupport::TimeZone.new('Hawaii')){Time.zone.now}
    value = Value.create(value: 0.32, stamp: weird_time )
    assert_equal weird_time.utc.to_s, value.reload.stamp.to_s
  end

  test "Value should store abitrary long improvement advice" do
    advice = "Some long Text! "
    repeat = 10000
    value = Value.create(value: 0.23, stamp: Time.now, improvement_advice: advice * repeat)
    assert_equal advice.length*repeat, value.reload.improvement_advice.length
  end

end
