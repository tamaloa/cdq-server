require 'test_helper'

class SubjectiveAssessmentTest < ActiveSupport::TestCase

  test "after creating a subjective assessment the dimensions should be available for assessment" do
    @app = apps(:apps_001)
    new_assessment = SubjectiveAssessmentSurvey.new(app: @app)
    assert_equal @app.dimensions.count, new_assessment.dimensions.count
  end

  test "a assessment should be stored permanently" do
    @app = apps(:apps_001)
    new_assessment = SubjectiveAssessmentSurvey.new(app: @app)
    new_assessment.dimensions.first[:satisfactory?] = true
    assert new_assessment.save
    assert_equal true, new_assessment.reload.dimensions.first[:satisfactory?]
  end

end
