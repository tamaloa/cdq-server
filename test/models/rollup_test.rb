require 'test_helper'

class RollupTest < ActiveSupport::TestCase

  def setup
    @metric = metrics(:metrics_001)
  end

  test "rollups should store rolled up values" do
    rollup = Rollup.new(metric: @metric)
    assert @metric.values.count >= 2
    rollup.values << @metric.values.first
    rollup.values << @metric.values.last
    assert rollup.save
  end

  test "metric rollups should be autocreated adding a value" do
    assert_difference ->{ Rollup.count }, Rollup.resolutions.count*3 do
      @metric.record(0.38, Time.now)
    end
  end

  test "rollup has default resolutions" do
    assert Rollup.resolutions.eql? [:hour, :day, :week, :month, :year]
  end

  test "metric rollup should be auto created for all resolutions" do
    @metric.record(0.5, Time.now)
    Rollup.resolutions.each do |resolution|
      refute_empty Rollup.where(metric: @metric, resolution: resolution)
    end
  end

  test "metric rollup should be only updated if value is recorded inside resolution" do
    Timecop.freeze(2013, 12, 1, 13, 10, 0) do
      @metric.record(0.2, Time.now)
      assert_no_difference ->{ Rollup.count } do
        @metric.record(0.6, Time.now + 20.minutes)
      end
    end

  end

  test "metric rollup should calculate avg, min, max values" do
    Timecop.freeze(2013, 12, 1, 13, 10, 0) do
      @metric.record(0.2, Time.now)
      @metric.record(0.6, Time.now + 20.minutes)
      rollup = Rollup.where(metric: @metric, resolution: :hour).first
      assert_equal ((0.6 + 0.2)/2), rollup.avg
      assert_equal 0.6, rollup.max
      assert_equal 0.2, rollup.min
    end
  end

  test "rollup should be auto created for metric, dimension and app" do
    @metric.record(0.5, Time.now)
    Rollup.resolutions.each do |resolution|
      refute_empty Rollup.where(metric: @metric, resolution: resolution)
      refute_empty Rollup.where(dimension: @metric.dimension, resolution: resolution)
      refute_empty Rollup.where(app: @metric.dimension.app, resolution: resolution)
    end
  end
end
