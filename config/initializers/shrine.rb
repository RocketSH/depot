require "shrine"
require "shrine/storage/memory"
require "shrine/storage/s3"

s3_options = {
  access_key_id: Rails.application.credentials.aws[:access_key_id],
  secret_access_key: Rails.application.credentials.aws[:secret_access_key],
  region: Rails.application.credentials.aws[:region],
  bucket: Rails.application.credentials.aws[:bucket_name]
}

if Rails.env.test?
  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new,
  }
else
  Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: "cache", **s3_options), # temporary
  store: Shrine::Storage::S3.new(**s3_options), # permanent
  public_store: Shrine::Storage::S3.new(public: true, upload_options: { cache_control: "public, max-age=15552000" }, **s3_options)
}
end

Shrine.plugin :activerecord           # loads Active Record integration
Shrine.plugin :cached_attachment_data # enables retaining cached file across form redisplays
Shrine.plugin :restore_cached_data    # extracts metadata for assigned cached files
Shrine.plugin :determine_mime_type    # helps determine mime type accurately
Shrine.plugin :backgrounding
Shrine.plugin :remove_invalid
Shrine.plugin :presign_endpoint, presign_options: lambda { |request|  
  filename = request.params['filename']
  type     = request.params['type']
{
    content_disposition: "inline; filename=\"#{filename}\"", 
    content_type: type, 
    content_length_range: 0..(5 * 1024 * 1024)
  }
}
