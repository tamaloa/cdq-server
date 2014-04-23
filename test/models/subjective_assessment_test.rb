require 'test_helper'

class SubjectiveAssessmentTest < ActiveSupport::TestCase

  test "new assessments default to satisfactory nil" do
    assessment = SubjectiveAssessment.create(dimension: Dimension.first)
    assert_equal nil, assessment.satisfactory
  end

end
