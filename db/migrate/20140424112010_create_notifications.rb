class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :app, index: true
      t.text :content
      t.string :title

      t.timestamps
    end
  end
end
