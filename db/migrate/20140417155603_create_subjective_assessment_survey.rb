class CreateSubjectiveAssessmentSurvey < ActiveRecord::Migration
  def change
    create_table :subjective_assessment_surveys do |t|
      t.references  :app
      t.timestamps
    end
  end
end
