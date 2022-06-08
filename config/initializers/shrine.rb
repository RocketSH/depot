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
    store: Shrine::Storage::S3.new(prefix: "store", **s3_options), # permanent
  }
end

Shrine.plugin :activerecord           # load Active Record integration
Shrine.plugin :restore_cached_data    # refresh metadata for cached files
Shrine.plugin :cached_attachment_data # for retaining cached file on form redisplays
Shrine.plugin :presign_endpoint, presign_options: -> (request) { 
  # Uppy will send the "filename" and "type" query parameters 
  filename = request.params["filename"]
  type     = request.params["type"]
 
  { 
    content_disposition:    ContentDisposition.inline(filename), # set download filename 
    content_type:           type,                                # set content type (required if using DigitalOcean Spaces) 
    content_length_range:   0..(5*1024*1024),                   # limit upload size to 5 MB 
  }
}

