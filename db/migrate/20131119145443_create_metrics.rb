class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.string :name
      t.text :description
      t.float :expectation
      t.float :weight
      t.references :dimension, index: true

      t.timestamps
    end
  end
end
