class AddDescriptionToMetric < ActiveRecord::Migration
  def change
    add_column :metrics, :description, :text
  end
end
