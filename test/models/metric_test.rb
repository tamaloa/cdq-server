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
    assert @metric.current_value.eql?(0.8)
  end

  test "metric recent_values should return the ten most recent values" do
    timestamp = Time.now
    100.times{@metric.record(0.3, timestamp - 10.minutes)}
    @metric.record(0, timestamp - 5.minutes)
    metrics(:metrics_002).record(1.0, timestamp)
    @metric.record(0.8, timestamp)
    assert_equal 10, @metric.recent_values.count
    assert_equal 0.8, @metric.recent_values.first.value
    assert_equal 0.0, @metric.recent_values(timestamp - 5.minutes).first.value
  end

  test "metric should only record values between zero and one" do
    refute @metric.record(1.1)
    refute @metric.record(-0.1)
    assert @metric.record(1.0)
    assert @metric.record(0.0)
  end

  test "metric should report if expectation of parent dimension would be met" do
    @metric.dimension.expectation = 0.0
    assert @metric.reload.expectation_met?
  end

  test "metric should return values for chart" do
    assert @metric.values_for_chart
  end

  test "metric score should return nil if no values were recorded" do
    metric_with_no_values = Metric.create(name: "Test")
    assert_nil metric_with_no_values.score(Time.now)
  end

end