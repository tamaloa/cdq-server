require 'test_helper'

class MetricsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @metric = Metric.create(name: "TestMetric001")
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:metrics)
  end


  test "should create metric" do
    assert_difference('Metric.count') do
      post :create, metric: { dimension_id:1, name:"Test-Metric", weight: 1 }
    end

    assert_redirected_to metric_path(assigns(:metric))
  end

  test "should create metric with same name but in different dimension" do
    assert_difference('Metric.count') do
      post :create, metric: { dimension_id:1, name:"Company-count-should-be-1500" }
    end

    assert_redirected_to metric_path(assigns(:metric))
  end

  test "should show metric" do
    get :show, id: @metric
    assert_response :success
  end

  test "should update metric" do
    patch :update, id: @metric, metric: { description: @metric.description, dimension_id: @metric.dimension_id, expectation: @metric.expectation, name: @metric.name, weight: @metric.weight }
    assert_redirected_to metric_path(assigns(:metric))
  end

  test "should destroy metric" do
    assert_difference('Metric.count', -1) do
      delete :destroy, id: @metric
    end

    assert_redirected_to metrics_path
  end
end
