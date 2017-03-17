require 'test_helper'

class DataAssetsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @data_asset = DataAsset.first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data_assets)
  end


  test "should show data_asset" do
    get :show, id: @data_asset
    assert_response :success
  end

end
