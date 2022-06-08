# redis://localhost:6379/1 is the default URL of a locally installed redis database.
# Sidekiq uses Redis to store all of its job and operational data
# By default, Sidekiq tries to connect to Redis at localhost:6379. This typically works great during development but needs tuning in production.

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
end
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
end

