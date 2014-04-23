class SubjectiveAssessmentSurvey < ActiveRecord::Base
  belongs_to :app
  has_many :subjective_assessments

  validates_presence_of :app

  after_create :set_subjective_assessments


  private

  def set_subjective_assessments
    self.subjective_assessments = app.dimensions.map{|d| SubjectiveAssessment.create!(dimension: d, subjective_assessment_survey: self)}
  end

end
