class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.string :name
      t.text :description
      t.float :expectation
      t.float :weight
      t.references :app, index: true

      t.timestamps
    end
  end
end
