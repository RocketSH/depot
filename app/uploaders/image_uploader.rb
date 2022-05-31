require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :derivatives
  plugin :default_storage, cache: :cache, store: :public_store
  plugin :store_dimensions # extracts dimensions of uploaded images and stores them into the metadata hash

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    { 
      thumbnail:  magick.resize_to_limit!(120, 120),
      profile: magick.resize_to_limit!(250, 250),
      display:  magick.resize_to_limit!(350, 350),
    }
  end

  Attacher.validate do
    validate_max_size 5*1024*1024, message: "is too large (max is 5 MB)"
    validate_mime_type %w[image/jpg image/jpeg image/png]
  end

  def generate_location(io, record: nil, name: nil, derivative: nil, **)
    record_model = record.class.name.to_s.downcase
    name = super # the default unique identifier
    [record_model, name].compact.join(‘/’)
  end
end
