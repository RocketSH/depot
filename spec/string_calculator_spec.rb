require "string_calculator.rb"

describe StringCalculator do
  describe ".add" do
    context "given an empty string" do
      it "returns zero" do
        expect(StringCalculator.add("")).to eq(0)
      end
    end

    context "given '10" do
      it "returns '10' " do
        expect(StringCalculator.add("10")).to eq(10)
      end
    end

    context "given '17, 100' " do
      it "returns '117' " do
        expect(StringCalculator.add("100,17")).to eq(117)
      end
    end
  end
end
