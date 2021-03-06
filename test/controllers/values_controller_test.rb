require 'test_helper'

class ValuesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @value = values(:values_001)
  end

  test "should create value" do
    TestAfterCommit.with_commits(true) do

      assert_difference('Value.count') do
            post :create, value: { metric_id: @value.metric_id, stamp: Time.now.utc, value: @value.value,
                                   improvement_advice: "Some Abitrary Text! "*100 }
      end

      assert_redirected_to value_path(assigns(:value))
      assert Value.last.metric.improvement_advice.present?
      assert Value.last.stamp.present?

    end
  end

  test "should show value" do
    get :show, id: @value
    assert_response :success
  end

end
