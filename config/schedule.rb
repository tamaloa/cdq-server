set :output, 'log/whenever_cron_errors.log'

every :hour do
  runner 'Rollup.calculate'
end
