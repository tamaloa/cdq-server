require 'test_helper'

class DimensionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @dimension = dimensions(:dimensions_001)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dimensions)
  end


  test "should create dimension" do
    assert_difference('Dimension.count') do
      post :create, dimension: { app_id: 1, name: "Test-Dimension", weight: 0.5 }
    end

    assert_redirected_to dimension_path(assigns(:dimension))
  end

  test "should create dimension and store all attributes" do
    assert_difference('Dimension.count') do
      post :create, dimension: { app_id: 1, name: "Test-Dimension", weight: 0.5, expectation: 0.5 }
    end

    assert_redirected_to dimension_path(assigns(:dimension))
  end

  test "should create dimension with same name for different app" do
    assert_difference('Dimension.count') do
      post :create, dimension: { app_id: 2, name: "Timeliness"}
    end
  end

  test "should update dimension expectation only if given" do
    old_expectation = dimensions(:dimensions_001).expectation
    assert_no_difference('Dimension.count') do
      post :create, dimension: { app_id: 1, name: "Availability"}
    end
    assert_equal old_expectation, Dimension.find_by_name_and_app_id("Availability", 1).expectation
  end

  test "should set dimension expectation if dimension newly created" do
    post :create, dimension: { app_id: 1, name: "A new Dimension", expectation: 0.7}
    assert_equal 0.7, Dimension.find_by_name_and_app_id("A new Dimension", 1).expectation
  end

  test "should not update dimension expectation for already existing dimension" do
    assert_no_difference('Dimension.count') do
      post :create, dimension: {app_id: 1, name: "Availability", expectation: 0.7}
    end
    assert_equal 0.3, Dimension.find_by_name_and_app_id("Availability", 1).expectation
  end

  test "should show dimension" do
    get :show, id: @dimension
    assert_response :success
  end


  test "should update dimension" do
    patch :update, id: @dimension, dimension: { app_id: @dimension.app_id, description: @dimension.description, expectation: @dimension.expectation, name: @dimension.name, weight: @dimension.weight }
    assert_redirected_to dimension_path(assigns(:dimension))
  end

  test "should destroy dimension" do
    assert_difference('Dimension.count', -1) do
      delete :destroy, id: @dimension
    end

    assert_redirected_to dimensions_path
  end
end
