class AddImprovementNoticesToMetrics < ActiveRecord::Migration
  def change
    add_column :metrics, :improvement_advice, :text
    Metric.all.each do |metric|
      last_value = metric.values.last
      next unless last_value
      current_improvement_advice = last_value.improvement_advice
      next if current_improvement_advice.blank?
      metric.update(improvement_advice: current_improvement_advice)
    end
  end
end
