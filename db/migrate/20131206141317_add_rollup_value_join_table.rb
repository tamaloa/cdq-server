class AddRollupValueJoinTable < ActiveRecord::Migration
  def change
    create_table :rollups_values do |t|
      t.references :rollup
      t.references :value
    end

    add_index :rollups_values, [:rollup_id, :value_id], unique: true

  end
end
