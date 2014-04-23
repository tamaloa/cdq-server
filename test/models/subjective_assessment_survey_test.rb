require 'test_helper'

class SubjectiveAssessmentSurveyTest < ActiveSupport::TestCase


  test "after creating a survey the assessments are present and linked to dimensions" do
    survey = SubjectiveAssessmentSurvey.create(app: App.first)
    assert_not_empty survey.subjective_assessments
    assert_equal Dimension, survey.subjective_assessments.first.dimension.class
  end

end
