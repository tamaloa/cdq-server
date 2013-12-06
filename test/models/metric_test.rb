require 'test_helper'

class MetricTest < ActiveSupport::TestCase

  def setup
    @metric = metrics(:metrics_001)
  end

  test "metric should record value and timestamp" do
    value = 0.38
    timestamp = Time.now
    assert @metric.record(value, timestamp)
    @metric.reload
    assert @metric.values.last.value.eql?(value)
    assert @metric.values.last.stamp.to_i == timestamp.to_i
  end

  test "metric should always return the most recent value" do
    timestamp = Time.now
    @metric.record(0.8, timestamp + 5.minutes)
    @metric.record(0, timestamp)
    assert @metric.values.last.value.eql?(0.8)
  end

end