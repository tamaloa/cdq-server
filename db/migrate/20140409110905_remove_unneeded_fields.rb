class RemoveUnneededFields < ActiveRecord::Migration
  def change
    remove_column :apps, :expectation
    remove_column :metrics, :expectation
    remove_column :metrics, :description
  end
end
