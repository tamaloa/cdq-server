require 'test_helper'

class DimensionTest < ActiveSupport::TestCase

  def setup
    @dimension = Dimension.new(name: 'expectation-test', expectation: 0.8)
  end

  test "dimension should report if expectation is met" do
    assert_nothing_raised do
      @dimension.expectation_met?
    end
  end

  test "dimension should report a current score" do
    assert @dimension.current_score
  end

  test "current_score should be average of last metric results" do
    dimension = dimensions(:dimensions_001)
    dimension.metrics.each{|m| m.record(0.5) }

    assert_equal 0.5, dimension.current_score
  end

  test "current_score should be weighed average of last metric results" do
    dimension = dimensions(:dimensions_001)
    dimension.metrics.each{|m| m.record(0.5) }
    metric = Metric.create!(name: "Another Metric", dimension: dimension, weight:2)
    metric.record(0.0)
    expected_average = ( 0.0 + 0.0 + 0.5 + 0.5 ) / 4
    assert_equal expected_average, dimension.reload.current_score
  end

  test "dimension score should work with metrics without values" do
    dimension_with_empty_metrics = Class.new SimpleDelegator do
      def metrics
        3.times{Metric.new()}
      end
    end

    dimension = dimension_with_empty_metrics.new Dimension.new

    assert_equal 0.0, dimension.score(Time.now)
  end

  test "dimension from the list of data quality dimensions should be set with associated description" do
    currency = Dimension.new(name: "Currency")
    assert_equal "The delay until changes in the source reflects in the data.", currency.description
  end

end
