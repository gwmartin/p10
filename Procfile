web: bundle exec rackup -p $PORT
worker: QUEUE=default bundle exec rake resque:work
scheduler: bundle exec rake resque:scheduler
