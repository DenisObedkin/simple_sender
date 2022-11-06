# frozen_string_literal: true

redis_url = proc { 'redis://localhost:6379/0' }

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url.call }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url.call }
end