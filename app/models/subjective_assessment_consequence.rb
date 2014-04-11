class SubjectiveAssessmentConsequence
  attr_accessor :subjective_assessment



  def initialize(subjective_assessment)
    @subjective_assessment = subjective_assessment
  end

  def bear
    subjective_assessment.dimensions.each do |dimension|
      next unless dimension.key?(:satisfactory)
      satisfactory_action(real_dimension(dimension)) if dimension[:satisfactory]
      unsatisfactory_action(real_dimension(dimension)) unless dimension[:satisfactory]
    end
  end

  def satisfactory_action(dimension)
    set_expectation_to_current_score(dimension) if dimension.current_score < dimension.expectation
    do_nothing(dimension)                   unless dimension.current_score < dimension.expectation
  end

  def set_expectation_to_current_score(dimension)
    dimension.update(expectation: dimension.current_score)
  end

  def do_nothing(dimension)
    true
  end

  def unsatisfactory_action(dimension)
    trigger_root_cause_analytics(dimension) if dimension.current_score <= dimension.expectation
    increase_expectation(dimension) unless dimension.current_score <= dimension.expectation
  end

  def increase_expectation(dimension)
    dimension.expectation += Figaro.env.expectation_step.to_d
    dimension.expectation = 1.0 if dimension.expectation > 1.0
    dimension.save
  end

  def trigger_root_cause_analytics(dimension)
    raise NotificationNotImplemented
  end

  def real_dimension(dimension)
    Dimension.where(app: subjective_assessment.app, name: dimension[:name]).first
  end

end

class NotificationNotImplemented < StandardError ; end