require_relative 'pixel'

RSpec.describe Pixel, type: Class do
  describe "#initialize" do
    it "creates a pixel with the specified parameters and if possible identifies dominant primary color" do
      pixel = Pixel.new(255, 200, 160)
      expect(pixel.red).to eq 255
      expect(pixel.green).to eq 200
      expect(pixel.blue).to eq 160
    end
    
    it "corrects a red value if it's less than 0" do
      pixel = Pixel.new(-7, 100, 100)
      expect(pixel.red).to eq 0
      expect(pixel.dominant_primary_color).to eq "there is no single dominant primary color"
    end
    
    it "corrects a blue value if it's less than 0" do
      pixel = Pixel.new(100, -10, 100)
      expect(pixel.green).to eq 0
      expect(pixel.dominant_primary_color).to eq "there is no single dominant primary color"
    end
    
    it "corrects a green value if it's less than 0" do
      pixel = Pixel.new(100, 100, -12)
      expect(pixel.blue).to eq 0
      expect(pixel.dominant_primary_color).to eq "there is no single dominant primary color"
    end

    it "corrects a red value if it's greater than 255" do
      pixel = Pixel.new(256, 100, 100)
      expect(pixel.red).to eq 255
      expect(pixel.dominant_primary_color).to eq "red"
    end
    
    it "corrects a green value if it's greater than 255" do
      pixel = Pixel.new(100, 258, 100)
      expect(pixel.green).to eq 255
      expect(pixel.dominant_primary_color).to eq "green"
    end
    
    it "corrects a blue value if it's greater than 255" do
      pixel = Pixel.new(100, 100, 300)
      expect(pixel.blue).to eq 255
      expect(pixel.dominant_primary_color).to eq "blue"
    end
  end
end
