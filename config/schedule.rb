set :output, 'log/whenever_cron_errors.log'
env :PATH, ENV['PATH']

every :hour do
  runner 'Rollup.calculate'
end
