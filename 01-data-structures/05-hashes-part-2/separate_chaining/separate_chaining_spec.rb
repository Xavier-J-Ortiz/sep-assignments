include RSpec

require_relative 'separate_chaining'

RSpec.describe SeparateChaining, type: Class do
  let(:star_wars_movies) { SeparateChaining.new(6) }
  let(:movies) { SeparateChaining.new(3) }
  before do
    star_wars_movies["Star Wars: The Phantom Menace"] = "Number One"
    star_wars_movies["Star Wars: Attack of the Clones"] = "Number Two"
    star_wars_movies["Star Wars: Revenge of the Sith"] = "Number Three"
    star_wars_movies["Star Wars: A New Hope"] = "Number Four"
    star_wars_movies["Star Wars: The Empire Strikes Back"] = "Number Five"
    star_wars_movies["Star Wars: Return of the Jedi"] = "Number Six"
  end

  describe "#index" do
    it "creates a hash key based on the string value passed in" do
      i = star_wars_movies.index("Star Wars: A New Hope", 6)
      expect(i).to eq 1
    end
  end

  describe "#hash[key] = value" do
    it "does not resize the array when a collision ocurrs if collision keys are the same" do
      hash = SeparateChaining.new(2)
      hash["key"] = "value"
      expect(hash.get_size).to eq 2
      hash["key"] = "second value"
      expect(hash.get_size).to eq 2
    end

    it "resizes the array when a collision ocurrs if collision keys are not the same" do
      hash = SeparateChaining.new(2)
      hash["key"] = "value"
      expect(hash.get_size).to eq 2
      hash["keytwo"] = "second value"
      expect(hash.get_size).to eq 4
    end
  end

  describe "#hash[key]" do
    it "correctly assigns a key value pair within the hash" do
      expect(star_wars_movies["Star Wars: A New Hope"]).to eq "Number Four"
    end
    it "returns nil if the value doesn't exist" do
      expect(star_wars_movies["misnomer"]).to eq nil
    end
  end

  describe "#load_factor" do
    it "returns the number of items in the hash divided by the size of the underlying array" do
      h = SeparateChaining.new(4)

      expect(h.load_factor == 0).to be true
      h["key"] = "value"
      h["keytwo"] = "valve"

      expect(h.load_factor).to eq 0.5
      h["keythree"] = "banue"

      expect(h.load_factor).to eq 0.375
    end
  end

  describe "#resize" do
    context "simple resizing" do
      it "doubles the size of the array when invoked" do
        expect(movies.get_size).to eq 3
        movies.resize
        expect(movies.get_size).to eq 6 
      end
    end

    context "multiple resizing" do
      before do
        movies["A New Hope"] = "Average"
        movies["Empire Strikes Back"] = "Excellent"
        movies["Return of the Jedi"] = "The Best"
        movies["Star Wars: The Clone Wars"] = "Very Interesting"
        movies["Star Wars: The Force Awakens"] = "Amazing Reboot"
        movies["Star Wars: The Last Jedi"] = "Lots of Hype!"
        movies["Star Wars: Episode IX"] = "Title TBD"
        movies["Star Wars: Magazines"] = "Don't Count"
        movies["Star Wars: Fan Fiction"] = "Can Get Sued"
      end

      it "correctly retrieves key-value pair on load_factor triggered resize" do 
        expect(movies["Star Wars: The Force Awakens"]).to eq "Amazing Reboot"
      end
    end
  end
end
