# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name


exit unless ENV['PERFORMANCE_SETUP']

measurement_frequency = 1.hour
time_range = 5.years
total_measurement_runs = time_range / measurement_frequency

number_of_apps = 3
max_dimensions_per_app = 20
max_metric_per_dimension = 20

values_per_run = number_of_apps * max_dimensions_per_app * max_metric_per_dimension

total_values = total_measurement_runs * values_per_run

p "A total of #{total_values} values will be stored in the database"

number_of_apps.times do |i|
  app = App.create(name: "App_#{i}")
  Random.rand(max_dimensions_per_app).times do |i|
    dimension = Dimension.create(name: "#{app.name}-Dim_#{i}", app: app)
    Random.rand(max_metric_per_dimension).times do |i|
      Metric.create(name: "#{dimension.name}-Metric_#{i}", dimension: dimension)
    end
  end
end

p "Finished initial creating Apps (#{App.count}), Dimensions (#{Dimension.count}), and Metrics (#{Metric.count})"

total_time = start = Time.now
stamp = time_range.ago

total_measurement_runs.to_i.times do |run|
  stamp = stamp + measurement_frequency
  Metric.all.each do |metric|
    metric.record(Random.rand, stamp)
  end
  now = Time.now
  p "Finished one run in: #{now - start}"
  start = now
end

p "Total Time needed was #{Time.now - total_time}"