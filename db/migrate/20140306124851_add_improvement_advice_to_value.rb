class AddImprovementAdviceToValue < ActiveRecord::Migration
  def change
    add_column :values, :improvement_advice, :text
  end
end
