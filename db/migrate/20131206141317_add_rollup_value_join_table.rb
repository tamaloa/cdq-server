class AddRollupValueJoinTable < ActiveRecord::Migration
  def change
    create_table :rollups_values do |t|
      t.references :rollup
      t.references :value
    end

  end
end
