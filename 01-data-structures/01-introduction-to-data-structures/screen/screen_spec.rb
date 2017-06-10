require_relative 'screen'

RSpec.describe Screen, type: Class do
  let(:screen) { Screen.new(10, 10) }

  describe "#insert" do
    it "inserts a pixel at the proper x, y coordinates" do
      pixel = Pixel.new(255, 200, 175)
      screen.insert(pixel, 1, 1)

      expect(screen.at(1, 1)).to eq pixel
    end

    it "retains color information upon insertion" do
      pixel = Pixel.new(255, 200, 175)
      screen.insert(pixel, 1, 1)

      p1 = screen.at(1, 1)
      expect(p1.red).to eq pixel.red
      expect(p1.green).to eq pixel.green
      expect(p1.blue).to eq pixel.blue
      expect(p1.dominant_primary_color).to eq pixel.dominant_primary_color
    end

    it "does not overwrite if a pixel already exists in position" do
      pixel = Pixel.new(255, 200, 175)
      screen.insert(pixel, 1, 1)

      pixel2 = Pixel.new(205, 2, 75)
      expect(screen.insert(pixel2, 1, 1)).to eq "Pixel already exists in this position. Use overwrite instead"

      p1 = screen.at(1, 1)
      expect(p1.red).to eq pixel.red
      expect(p1.green).to eq pixel.green
      expect(p1.blue).to eq pixel.blue
      expect(p1.dominant_primary_color).to eq pixel.dominant_primary_color
    end
  end

  describe "#overwrite" do
    it "does overwrite a pixel located at x, y in the screen when overwrite method is used" do
      pixel = Pixel.new(255, 200, 175)
      screen.insert(pixel, 1, 1)

      pixel = Pixel.new(205, 2, 75)
      screen.overwrite(pixel, 1, 1)

      p1 = screen.at(1, 1)
      expect(p1.red).to eq pixel.red
      expect(p1.green).to eq pixel.green
      expect(p1.blue).to eq pixel.blue
      expect(p1.dominant_primary_color).to eq pixel.dominant_primary_color
    end
    it "doesn't overwrite when there's nothing else to overwrite (i.e. empty space on screen)" do
      pixel = Pixel.new(205, 2, 75)
      expect(screen.overwrite(pixel, 1, 1)).to eq "No pixel entry exists here. Use insert instead."

      p1 = screen.at(1, 1)
      expect(p1).to eq nil
    end
  end

    describe "#at" do
      it "returns the pixel at a specific location" do
        pixel = Pixel.new(255, 200, 175)
        screen.insert(pixel, 1, 2)

        p1 = screen.at(1, 2)
        expect(p1).to eq pixel
      end

      it "handles invalid x, y values gracefully" do
        pixel = screen.at(-1, -1)

        expect(pixel).to eq nil
      end
    end

  end
