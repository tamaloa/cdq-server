require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @app = apps(:apps_001)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apps)
  end


  test "should create app" do

    app = {
        name: 'test-app',
        expectation: 0.8,
        dimensions: [
            {name: "Bla",
            description: "DA",
            expectation: 0.7,
            metrics: [
                {name: "C001",
                description: "Blablabla",
                weight: 0.5},
                {name: "C001",
                description: "Blablabla",
                weight: 0.5}
            ]}
        ]
    }

    #{"name"=>"test2", "expectation"=>0.4,
    # "dimensions"=>[
    #     {"name"=>"completeness",
    #      "metrics"=>[{"name"=>"C001"}, {"name"=>"C002", "weight"=>0.5}]},
    #     {"name"=>"test4"}], "app"=>{"name"=>"test2", "expectation"=>0.4}}


    assert_difference('App.count') do
      post :create, app: app
    end

    assert_redirected_to app_path(assigns(:app))
  end

  test "should show app" do
    get :show, id: @app
    assert_response :success
  end

  test "should update app" do
    patch :update, id: @app, app: { expectation: @app.expectation, name: @app.name }
    assert_redirected_to app_path(assigns(:app))
  end

  test "should destroy app" do
    assert_difference('App.count', -1) do
      delete :destroy, id: @app
    end

    assert_redirected_to apps_path
  end
end
