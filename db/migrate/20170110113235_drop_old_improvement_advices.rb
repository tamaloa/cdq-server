class DropOldImprovementAdvices < ActiveRecord::Migration
  def change
    remove_column :values, :improvement_advice
  end
end
