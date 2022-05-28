require 'rails_helper'

RSpec.describe ImageUploader do
  let(:valid_image) { create(:zootopia) }
  let(:image) { valid_image.image}
  let(:derivatives) { valid_image.image_derivatives }

  context "sucessful proccessing" do
    it "can attach images" do
      expect(valid_image.image.storage_key).to eq(:store) 
    end

    it "extracts metadata" do
      expect(image.mime_type).to eq("image/jpeg")
      expect(image.extension).to eq("jpg")
      expect(image.size).to be_instance_of(Integer)
    end
    
    it "generates derivatives" do
      expect(derivatives[:thumbnail]).to  be_kind_of(Shrine::UploadedFile)
      expect(derivatives[:profile]).to be_kind_of(Shrine::UploadedFile)
      expect(derivatives[:display]).to  be_kind_of(Shrine::UploadedFile)
    end
  end

end
