require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) {create(:product)}
  let(:zootopia) {create(:zootopia)}

  # comment out subject syntax since we have FactoryBot 
  
  # subject { described_class.new(
  #   title: "Try Everything",
  #   description: "Oh, oh, oh, oh, oh
  #   Oh, oh, oh, oh, oh
  #   Oh, oh, oh, oh, oh
  #   Oh, oh, oh, oh, oh
  #   I messed up tonight
  #   I lost another fight
  #   Lost to myself, but I'll just start again",
  #   image_url: "https://insidethemagic.net/wp-content/uploads/2016/12/zootopia1.jpg",
    # price: rand(1..50000))
   # } 

  it "is valid with valid attributes" do
    # expect(subject).to be_valid
    expect(product).to be_valid
  end

  it "is not valid without a title" do
    # subject.title = nil
    # expect(subject).to_not be_valid
    product.title = nil
    expect(product).to_not be_valid
  end

  it "is not valid without a description" do
    # subject.description = nil
    # expect(subject).to_not be_valid
    product.description = nil
    expect(product).to_not be_valid
  end

  it "is not valid without a image url" do
    subject.image_url = nil
    # expect(subject).to_not be_valid
    product.image_url = nil
    expect(product).to_not be_valid
  end

  
  it "is valid with correc image url suffix" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg
      http://a.b.c/x/y/z/fred.gif }

    ok.each do |image_url|
      # subject.image_url = image_url
      # expect(subject).to be_valid
      product.image_url = image_url
      expect(product).to be_valid
    end
  end

  it "is invalid with incorrec image url suffix" do
    bad = %w{ fred.doc fred.gif/more fred.gif.more }

   bad.each do |image_url|
      # subject.image_url = image_url
      # expect(subject).to_not be_valid
      product.image_url = image_url
      expect(product).to_not be_valid
    end
  end

  it "is not valid without a price" do
    # subject.price = nil
    # expect(subject).to_not be_valid
    product.price = nil
    expect(product).to_not be_valid
  end

  it "is not valid when price less than 0" do
  #   subject.price = rand(0..-100000)
  #   expect(subject).to_not be_valid
    product.price = rand(0..-100000)
    expect(product).to_not be_valid
  end
end
