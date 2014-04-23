class CreateSubjectiveAssessments < ActiveRecord::Migration
  def change
    create_table :subjective_assessments do |t|
      t.boolean     :satisfactory
      t.references  :subjective_assessment_survey
      t.references  :dimension
      t.timestamps
    end
  end
end
