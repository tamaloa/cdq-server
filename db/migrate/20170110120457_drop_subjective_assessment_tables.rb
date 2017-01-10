class DropSubjectiveAssessmentTables < ActiveRecord::Migration
  def change
    drop_table :subjective_assessments
    drop_table :subjective_assessment_surveys
  end
end
