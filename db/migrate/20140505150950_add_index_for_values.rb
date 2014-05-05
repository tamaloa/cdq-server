class AddIndexForValues < ActiveRecord::Migration
  def change
    add_index :values, :stamp
    add_index :rollups, :stamp
  end
end
