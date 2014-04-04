require 'test_helper'

class AppTest < ActiveSupport::TestCase

  test "app should report a current score" do
    assert apps(:apps_001).current_score
  end

  test "current_score should be average of last metric results" do
    app = App.create(name: "Current Score App")
    3.times do |i|
      dim = Dimension.create(app_id: app.id, name: "Dimension #{i}")
      Metric.create(dimension_id: dim.id, name: "Metric")
    end

    app.dimensions.each do |dimension|
      dimension.metrics.each{|m| m.record(0.5)}
    end

    assert_equal 0.5, app.current_score
  end
end
