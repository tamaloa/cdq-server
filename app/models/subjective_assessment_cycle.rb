class SubjectiveAssessmentCycle
  attr_accessor :survey


  def initialize(survey)
    @survey = survey
  end

  def run
    survey.subjective_assessments.each do |assessment|
      next if assessment.satisfactory.eql?(nil)
      satisfactory_action(assessment.dimension) if assessment.satisfactory
      unsatisfactory_action(assessment.dimension) unless assessment.satisfactory
    end
  end

  def satisfactory_action(dimension)
    if dimension.current_score < dimension.expectation
      set_expectation_to_current_score(dimension)
    else
      do_nothing(dimension)
    end
  end

  def set_expectation_to_current_score(dimension)
    dimension.update(expectation: dimension.current_score)
  end

  def do_nothing(dimension)
    true
  end

  def unsatisfactory_action(dimension)
    if dimension.current_score <= dimension.expectation
      trigger_root_cause_analytics(dimension)
    else
      increase_expectation(dimension)
    end
  end

  def increase_expectation(dimension)
    dimension.expectation += Figaro.env.expectation_step.to_d
    dimension.expectation = 1.0 if dimension.expectation > 1.0
    dimension.save
  end

  def trigger_root_cause_analytics(dimension)
    Notification.create(app: dimension.app,
                        title: "Subjective Assessment triggered root cause analysis for #{dimension.app}",
                        content: "Please analyze why the dimension #{dimension.name} subjective assessment triggered rca.")
  end

end
