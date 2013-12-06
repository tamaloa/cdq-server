class CreateRollups < ActiveRecord::Migration
  def change
    create_table :rollups do |t|
      t.timestamp :stamp
      t.float :avg
      t.float :min
      t.float :max
      t.string :resolution
      t.references :metric, index: true
      t.references :dimension, index: true
      t.references :app, index: true
    end
  end
end
