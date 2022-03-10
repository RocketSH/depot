require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) {create(:product)}
  let(:zootopia) {create(:zootopia)}

  context "create& save product validation" do
    it "is valid with valid attributes" do
      expect(product).to be_valid
    end

    it "is not valid without a title" do
      product.title = nil
      expect(product).to_not be_valid
    end

    it "is not valid without a description" do
      product.description = nil
      expect(product).to_not be_valid
    end

    it "is not valid without a image url" do
      product.image_url = nil
      expect(product).to_not be_valid
    end

    
    it "is valid with correc image url suffix" do
      ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
        http://a.b.c/x/y/z/fred.gif }

      ok.each do |image_url|
        product.image_url = image_url
        expect(product).to be_valid
      end
    end

    it "is invalid with incorrec image url suffix" do
      bad = %w{ fred.doc fred.gif/more fred.gif.more }

    bad.each do |image_url|
        product.image_url = image_url
        expect(product).to_not be_valid
      end
    end

    it "is not valid without a price" do
      product.price = nil
      expect(product).to_not be_valid
    end

    it "is not valid when price less than 0" do
      product.price = rand(0..-100000)
      expect(product).to_not be_valid
    end
  end

  context "destroy product" do
    it "fail if line item referencing" do
      zootopia
      cart = Cart.create
      line_item = LineItem.create(cart_id: cart.id, product_id: zootopia.id)

      expect(zootopia.destroy).to eq(false)
    end

    it "destroy successfully" do
      product
      product.destroy

      expect(product).to be_destroyed
    end
  end
end
