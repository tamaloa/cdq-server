class SetSubjectiveAssessmentDefault < ActiveRecord::Migration
  def change
    change_column :subjective_assessments, :satisfactory, :boolean, default: nil
  end
end
