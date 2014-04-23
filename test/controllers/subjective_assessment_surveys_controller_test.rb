require 'test_helper'

class SubjectiveAssessmentSurveysControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @subjective_assessment = SubjectiveAssessmentSurvey.create(app: App.first)
  end

  test "should get index" do
    get :index
    assert_response :success

  end

  test "should get new" do
    get :new, {subjective_assessment_survey: {app_id: 1}}
    assert_response :success
  end

  test "should show subjective_assessment" do
    get :show, id: @subjective_assessment
    assert_response :success
  end

end
