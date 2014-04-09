require 'test_helper'

class RollupTest < ActiveSupport::TestCase

  def setup
    # Instead of mocking we create a very small test suite :)
    App.destroy_all
    @app = App.create!(name: "Test App")
    2.times{ Dimension.create!(name: "Dimension - #{rand}", app: @app) }
    @app.dimensions.each do |dimension|
      2.times{ Metric.create!(name: "Metric - #{rand}", dimension: dimension) }
    end
    @metric = Metric.first
  end


  test "metric rollups should be autocreated adding a value outside smalles resolution" do
    Timecop.freeze(2013, 12, 1, 13, 10, 0) do
      Rollup.calculate(Time.now)
      expected_new_rollups_per_hour = Metric.count + Dimension.count + App.count
      assert_difference ->{ Rollup.count }, expected_new_rollups_per_hour do
        Rollup.calculate(Time.now + 1.hour)
      end
    end
  end

  test "rollup has default resolutions" do
    assert Rollup.resolutions.eql? [:hour, :day, :week, :month, :year]
  end

  test "metric rollup should be auto created for all resolutions" do
    time = Time.now
    @metric.record(0.5, time)
    Rollup.calculate(time)
    Rollup.resolutions.each do |resolution|
      refute_empty Rollup.where(metric: @metric, resolution: resolution)
    end
  end


  test "metric rollup should be only updated if value is recorded inside resolution" do
    Timecop.freeze(2013, 12, 1, 13, 10, 0) do
      @metric.record(0.2, Time.now)
      Rollup.calculate(Time.now)
      assert_no_difference ->{ Rollup.count } do
        @metric.record(0.6, Time.now + 20.minutes)
        Rollup.calculate(Time.now + 20.minutes)
      end
    end

  end

  test "metric rollup should calculate avg, min, max values" do
    Timecop.freeze(2013, 12, 1, 13, 10, 0) do
      @metric.record(0.2, Time.now)
      Rollup.calculate(Time.now)
      @metric.record(0.6, Time.now + 20.minutes)
      Rollup.calculate(Time.now + 20.minutes)
      rollup = Rollup.where(metric: @metric, resolution: :hour).first
      assert_equal ((0.6 + 0.2)/2), rollup.avg
      assert_equal 0.6, rollup.max
      assert_equal 0.2, rollup.min
    end
  end


  test "rollup should be auto created for metric, dimension and app" do
    @metric.record(0.5, time = Time.now)
    Rollup.calculate(time)
    Rollup.resolutions.each do |resolution|
      refute_empty Rollup.where(metric: @metric, resolution: resolution)
      refute_empty Rollup.where(dimension: @metric.dimension, resolution: resolution)
      refute_empty Rollup.where(app: @metric.dimension.app, resolution: resolution)
    end
  end

  test "rollups should be calculated even if no values exist" do

    Value.delete_all
    number_of_things_to_roll_up = Metric.count + Dimension.count + App.count
    expected_rollups = number_of_things_to_roll_up * Rollup.resolutions.count
    assert_difference ->{Rollup.count}, expected_rollups do
      Rollup.calculate
    end

  end

  test "rollup should only be calculated if it has not yet been calculated for the given timestamp" do
    pending
  end

  test "rollup calculation should try and calculate several missing rollbacks" do
    pending
  end

end
