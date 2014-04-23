class LinkSubjectiveAssessmentSurveyDirectlyToAssessments < ActiveRecord::Migration
  def change
    remove_column :subjective_assessment_surveys, :dimensions
  end
end
