# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name


exit unless ENV['PERFORMANCE_SETUP']

measurement_frequency = 1.hour
time_range = 5.years
total_measurement_runs = time_range / measurement_frequency

number_of_apps = 20
dimensions_per_app = 10
metric_per_dimension = 10

values_per_run = number_of_apps * dimensions_per_app * metric_per_dimension

total_values = total_measurement_runs * values_per_run

p "A total of #{total_values} values will be stored in the database"

starting_time = time_range.ago

total_time = start = Time.now


number_of_apps.times do |i|
  app = App.create(name: "App_#{i}")
  dimensions_per_app.times do |i|
    dimension = Dimension.create(name: "#{app.name}-Dim_#{i}")
    app.dimensions << dimension
    metric_per_dimension.times do |i|
      Metric.create(name: "#{dimension.name}-Metric_#{i}")
    end
  end
end