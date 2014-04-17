require 'test_helper'

class SubjectiveAssessmentConsequenceTest < ActiveSupport::TestCase

  def setup
    @app = apps(:apps_001)
    @dimension = @app.dimensions.where(name: 'Availability').first
    @subjective_assessment_survey = SubjectiveAssessmentSurvey.new(app: @app)
    @consequence = SubjectiveAssessmentCycle.new(@subjective_assessment_survey)
  end

  test "bearing the consequences should be possible" do
    assert @consequence.bear
  end

  test "bearing the consequences should do nothing if no feedback was given" do
    10.times{ @consequence.bear }
  end

  test "bearing the consequence of a bad test should increase dimensions expectation" do
    @subjective_assessment_survey.dimensions.select{|d| d[:name] == @dimension.name}.first[:satisfactory] = false
    @consequence = SubjectiveAssessmentCycle.new(@subjective_assessment_survey)

    assert_difference ->{Dimension.find(@dimension.id).expectation}, 0.1 do
      @consequence.bear
    end

  end

  test "bearing the consequence of a bad test several times should at some point trigger a notification" do
   @subjective_assessment_survey.dimensions.select{|d| d[:name] == @dimension.name}.first[:satisfactory] = false
    @consequence = SubjectiveAssessmentCycle.new(@subjective_assessment_survey)

    assert_raise NotificationNotImplemented do
      10.times{@consequence.bear}
    end
  end

  test "a dimension which satisfies the subject and score smaller than expectation should lower the expectation" do
    @dimension.update(expectation: 1.0)
    @dimension.reload
    @subjective_assessment_survey.dimensions.select{|d| d[:name] == @dimension.name}.first[:satisfactory] = true
    @consequence = SubjectiveAssessmentCycle.new(@subjective_assessment_survey)

    assert @dimension.current_score <= @dimension.expectation

    @consequence.bear

    assert_equal @dimension.current_score, @dimension.reload.expectation

  end

  test "a dimension which satisfies the subject and with a score higher than expectation should do nothing anymore" do
    @dimension.update(expectation: 0.2)
    @dimension.reload
    @subjective_assessment_survey.dimensions.select{|d| d[:name] == @dimension.name}.first[:satisfactory] = true
    @consequence = SubjectiveAssessmentCycle.new(@subjective_assessment_survey)

    assert @dimension.current_score > @dimension.expectation

    @consequence.bear

    assert_equal @dimension.to_yaml, @dimension.reload.to_yaml
  end

end
