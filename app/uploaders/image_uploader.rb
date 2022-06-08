require "image_processing/mini_magick"

class ImageUploader < Shrine
  plugin :derivatives, create_on_promote: true # Save image in multiple version
  plugin :validation
  plugin :validation_helpers

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    { 
      thumbnail:  magick.resize_to_limit!(120, 120),
      profile: magick.resize_to_limit!(250, 250),
      display:  magick.resize_to_limit!(350, 350),
    }
  end

  Attacher.validate do
    validate_size 1..5*1024*1024
    validate_mime_type %w[image/jpg image/jpeg image/png]
  end
end
