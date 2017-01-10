require 'test_helper'

class ViewMainPagesTest < ActionDispatch::IntegrationTest

  test "viewing and navigating the main pages should work" do
    get '/'
    assert_response :success
    get '/apps/1'
    assert_response :success
    get '/dimensions/1'
    assert_response :success
    get '/metrics/1'
    assert_response :success
    get '/values/1'
    assert_response :success
  end
end
