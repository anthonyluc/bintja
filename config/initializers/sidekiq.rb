Sidekiq.configure_server do |config|
    config.redis = { url: ENV["REDISCLOUD_URL"] }
    schedule_file = "config/schedule.yml"
    if File.exists?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end
  