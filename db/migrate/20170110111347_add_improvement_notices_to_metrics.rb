class AddImprovementNoticesToMetrics < ActiveRecord::Migration
  def change
    add_column :metrics, :improvement_advice, :text
    Metric.all.each do |metric|
      current_improvement_advice = metric.values.last.improvement_advice
      metric.update(improvement_advice: current_improvement_advice)
    end
  end
end
