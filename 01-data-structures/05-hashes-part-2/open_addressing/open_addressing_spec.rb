include RSpec

require_relative 'node'
require_relative 'open_addressing'

RSpec.describe OpenAddressing, type: Class do
  let(:star_wars_movies) { OpenAddressing.new(6) }
  let(:movies) { OpenAddressing.new(3) }
  let(:hash) {OpenAddressing.new(1)}

  before do
    star_wars_movies["Star Wars: The Phantom Menace"] = "Number One"
    star_wars_movies["Star Wars: Attack of the Clones"] = "Number Two"
    star_wars_movies["Star Wars: Revenge of the Sith"] = "Number Three"
    star_wars_movies["Star Wars: A New Hope"] = "Number Four"
    star_wars_movies["Star Wars: The Empire Strikes Back"] = "Number Five"
    star_wars_movies["Star Wars: Return of the Jedi"] = "Number Six"
  end

  describe "#hash[key] = value" do
    before do
      hash["key"] = "value"
    end

    it "adds a value to the hash" do 
      expect(hash.get_size).to eq 1
    end
    context "When a hash entry exists for that specific key," do
      it "does not resizes on full hash" do
        hash["key"] = "second value"
        expect(hash.get_size).to eq 1
        expect(hash["key"]).to eq "second value"
      end 
    end

    context "When a hash entry does not exist for that specific key," do
      it "resizes on full hash" do
        hash["keytwo"] = "second value"
        expect(hash.get_size).to eq 2
        expect(hash["keytwo"]).to eq "second value"
      end
    end

    it "does not resizes the array when a hash is not full" do
      hash = OpenAddressing.new(4)
      hash["key"] = "value"
      expect(hash.get_size).to eq 4
    end
  end

  describe "#hash[key]"do
    it "sets the value of key to value" do
      expect(star_wars_movies["Star Wars: Revenge of the Sith"]).to eq "Number Three"
    end
    context "when no entry has been assigned to a key, "
    it "return nil" do
      expect(star_wars_movies["misnomer"]).to eq nil
    end
  end

  describe "#index" do
    it "creates a hash key based on the string value passed in" do
      i = star_wars_movies.index("Star Wars: A New Hope", 6)
      expect(i).to eq 1
    end
  end

  describe "#find_next_open_index" do
    it "returns nil if there are no open indices" do
      inception = OpenAddressing.new(1)
      inception["The Original"] = "The Best Movie Ever"
      expect(inception.find_next_open_index(0)).to eq (nil)
    end

    it "finds the next open index" do
      inception = OpenAddressing.new(2)
      inception["The Original"] = "The Best Movie Ever"
      expect(inception.find_next_open_index(0)).to eq (1)
    end
  end

  describe "#resize" do
    context "resizes a structure to twice it's original size" do
      it "doubles the size of the array when invoked" do
        expect(movies.get_size).to eq 3
        movies.resize
        expect(movies.get_size).to eq 6
      end
    end

    context "When adding nodes to an already existing structure, " do
      before do
        movies["A New Hope"] = "Average"
        movies["Empire Strikes Back"] = "Excellent"
        movies["Return of the Jedi"] = "The Best"
        movies["Star Wars: The Clone Wars"] = "Very Interesting"
        movies["Star Wars: The Force Awakens"] = "Amazing Reboot"
        movies["Star Wars: The Last Jedi"] = "Lots of Hype!"
        movies["Star Wars: Episode IX"] = "Title TBD"
      end

      it "verifies that there was a load_factor > 1 triggered resize" do
        expect(movies.get_size).to eq 12
      end

      it "is able to access all key value pairs" do
        movies.resize
        expect(movies.get_size).to eq 24 
        expect(movies["A New Hope"]).to eq "Average"
        expect(movies["Empire Strikes Back"]).to eq "Excellent"
        expect(movies["Return of the Jedi"]).to eq "The Best"
        expect(movies["Star Wars: The Clone Wars"]).to eq "Very Interesting"
        expect(movies["Star Wars: The Force Awakens"]).to eq "Amazing Reboot"
        expect(movies["Star Wars: The Last Jedi"]).to eq "Lots of Hype!"
        expect(movies["Star Wars: Episode IX"]).to eq "Title TBD"
      end
    end
  end
end
