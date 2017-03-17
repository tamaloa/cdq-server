class CreateDataAssets < ActiveRecord::Migration
  def change
    create_table :data_assets do |t|
      t.string :name
      t.text :description
      t.references :app, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
