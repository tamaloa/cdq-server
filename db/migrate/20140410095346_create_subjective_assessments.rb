class CreateSubjectiveAssessments < ActiveRecord::Migration
  def change
    create_table :subjective_assessments do |t|
      t.text :dimensions
      t.references :app

      t.timestamps
    end
  end
end
