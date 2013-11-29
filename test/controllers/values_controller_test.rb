require 'test_helper'

class ValuesControllerTest < ActionController::TestCase
  setup do
    @value = values(:values_001)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:values)
  end


  test "should create value" do
    assert_difference('Value.count') do
      post :create, value: { metric_id: @value.metric_id, stamp: @value.stamp, value: @value.value }
    end

    assert_redirected_to value_path(assigns(:value))
  end

  test "should show value" do
    get :show, id: @value
    assert_response :success
  end

  test "should update value" do
    patch :update, id: @value, value: { metric_id: @value.metric_id, stamp: @value.stamp, value: @value.value }
    assert_redirected_to value_path(assigns(:value))
  end

  test "should destroy value" do
    assert_difference('Value.count', -1) do
      delete :destroy, id: @value
    end

    assert_redirected_to values_path
  end
end
