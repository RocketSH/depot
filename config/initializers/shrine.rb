require "shrine"

if Rails.env.test?
  require "shrine/storage/memory"

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new,
  }
else
  require "shrine/storage/s3"

  s3_options = {
    access_key_id: Rails.application.credentials.aws[:access_key_id],
    secret_access_key: Rails.application.credentials.aws[:secret_access_key],
    region: Rails.application.credentials.aws[:region],
    bucket: Rails.application.credentials.aws[:bucket_name]
  }

  Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary
  store: Shrine::Storage::S3.new(prefix: "store", **s3_options), # permanent
  }
end

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :derivatives, create_on_promote: true # Save image in multiple version
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :remove_invalid
Shrine.plugin :determine_mime_type    # helps determine mime type accurately
Shrine.plugin :backgrounding
Shrine.plugin :presign_endpoint
