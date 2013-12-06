class CreateRollups < ActiveRecord::Migration
  def change
    create_table :rollups do |t|
      t.timestamp :stamp
      t.float :avg, default: 0.0
      t.float :min, default: 1.0
      t.float :max, default: 0.0
      t.string :resolution
      t.references :metric, index: true
      t.references :dimension, index: true
      t.references :app, index: true
    end
  end
end
