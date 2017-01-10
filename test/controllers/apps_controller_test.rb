require 'test_helper'

class AppsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

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

    assert_difference('App.count') do
      post :create, app: app
    end

    assert_redirected_to app_path(assigns(:app))
  end

  test "should create another app via json" do
    app = { "name" => "ipib - (staging)" }
    assert_nothing_raised do
      post :create, app: app, format: :json
    end

    assert_response :success
    assert_not_nil assigns(:app)
  end

  test "should not create app which already exits" do
    app = { name: 'ipib' }
    assert_no_difference('App.count') do
      post :create, app: app
    end
  end

  test "should show app" do
    get :show, id: @app
    assert_response :success
  end

  test "should update app" do
    patch :update, id: @app, app: { name: @app.name }
    assert_redirected_to app_path(assigns(:app))
  end

  test "should destroy app" do
    assert_difference('App.count', -1) do
      delete :destroy, id: @app
    end

    assert_redirected_to apps_path
  end
end
