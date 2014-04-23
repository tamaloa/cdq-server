class SubjectiveAssessment < ActiveRecord::Base
  belongs_to :subjective_assessment_survey
  belongs_to :dimension

  validates_presence_of :dimension

  def name
    dimension.name
  end

  def description
    dimension.description
  end
end
