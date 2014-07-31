require 'test_helper'

class SubjectiveAssessmentCycleTest < ActiveSupport::TestCase

  def setup

    @subjective_assessment_survey = SubjectiveAssessmentSurvey.create(app: apps(:apps_001))
    @assessment = @subjective_assessment_survey.subjective_assessments.where(dimension_id: 1).first
    @assessment_cycle = SubjectiveAssessmentCycle.new(@subjective_assessment_survey)
  end

  test "bearing the consequences should be possible" do
    assert @assessment_cycle.run
  end

  test "bearing the consequences should do nothing if no feedback was given" do
    10.times{ @assessment_cycle.run }
  end

  test "bearing the consequence of a bad test should increase dimensions expectation" do
    @assessment.update(satisfactory: false)
    @assessment_cycle.survey.reload

    assert_difference ->{ @assessment.dimension.expectation}, 0.1 do
      @assessment_cycle.run
      @assessment.dimension.reload
    end

  end

  test "bearing the consequence of a bad test several times should at some point trigger a notification" do
    @assessment.update(satisfactory: false)
    @assessment_cycle.survey.reload

    assert_difference ->{ Notification.count } do
      9.times{@assessment_cycle.run}
    end
  end

  test "a dimension which satisfies the subject and score smaller than expectation should lower the expectation" do
    @assessment.dimension.update(expectation: 1.0)
    @assessment.update(satisfactory: true)
    dimension = @assessment.dimension.reload
    @assessment_cycle.survey.reload

    assert dimension.current_score <= dimension.expectation

    @assessment_cycle.run

    assert_equal dimension.current_score, dimension.reload.expectation

  end

  test "a dimension which satisfies the subject and with a score higher than expectation should do nothing anymore" do
    @assessment.dimension.update(expectation: 0.1)
    @assessment.update(satisfactory: true)
    @assessment_cycle.survey.reload
    dimension = @assessment.dimension.reload

    assert dimension.current_score > dimension.expectation

    @assessment_cycle.run

    assert_equal dimension.to_yaml, dimension.reload.to_yaml
  end

end
