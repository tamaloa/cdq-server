class RenameSubjectiveAssessmentToSubjectiveAssessmentSurvey < ActiveRecord::Migration
  def change
    rename_table :subjective_assessments, :subjective_assessment_surveys
  end
end
