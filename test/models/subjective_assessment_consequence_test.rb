require 'test_helper'

class SubjectiveAssessmentConsequenceTest < ActiveSupport::TestCase

  def setup
    @app = apps(:apps_001)
    # dimension
    # dimension_with_empty_metrics = Class.new SimpleDelegator do
    #       def metrics
    #         3.times{Metric.new()}
    #       end
    #     end
    #
    #     dimension = dimension_with_empty_metrics.new Dimension.new
    @subjective_assessment = SubjectiveAssessment.new(app: @app)
    @consequence = SubjectiveAssessmentConsequence.new(@subjective_assessment)
  end

  test "bearing the consequences should be possible" do
    assert @consequence.bear
  end

  test "bearing the consequences should do nothing if no feedback was given" do
    10.times{ @consequence.bear }
  end

  test "bearing the consequence of a bad test should increase dimensions expectation" do
    @bad_dimension = @app.dimensions.first
    @subjective_assessment.dimensions.first[:satisfactory?] = false
    @consequence = SubjectiveAssessmentConsequence.new(@subjective_assessment)

    assert_difference ->{Dimension.find(@bad_dimension.id).expectation}, 0.1 do
      @consequence.bear
    end

  end

  test "bearing the consequence of a bad test several times should at some point trigger a notification" do
    @bad_dimension = @app.dimensions.first
    @subjective_assessment.dimensions.first[:satisfactory?] = false
    @consequence = SubjectiveAssessmentConsequence.new(@subjective_assessment)

    assert_raise NotificationNotImplemented do
      10.times{@consequence.bear}
    end
  end

  test "a dimension which satisfies the subject and score smaller than expectation should lower the expectation" do
    @good_dimension = @app.dimensions.first
    @good_dimension.update(expectation: 1.0)
    @subjective_assessment.dimensions.first[:satisfactory?] = true
    @consequence = SubjectiveAssessmentConsequence.new(@subjective_assessment)

    @consequence.bear

    assert_equal @good_dimension.current_score, @good_dimension.reload.expectation

  end

  test "a dimension which satisfies the subject and with a score higher than expectation should do nothing anymore" do
    @good_dimension = @app.dimensions.first
    @good_dimension.update(expectation: 0.2)
    @good_dimension.reload
    @subjective_assessment.dimensions.first[:satisfactory?] = true
    @consequence = SubjectiveAssessmentConsequence.new(@subjective_assessment)

    assert @good_dimension.current_score > @good_dimension.expectation

    @consequence.bear

    assert_equal @good_dimension.to_yaml, @good_dimension.reload.to_yaml
  end

end
