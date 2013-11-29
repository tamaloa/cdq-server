class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.timestamp :stamp
      t.float :value
      t.references :metric, index: true
    end
  end
end
