include RSpec

require_relative 'node'
require_relative 'open_addressing'

RSpec.describe OpenAddressing, type: Class do
  let(:star_wars_movies) { OpenAddressing.new(6) }

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
    it "does not resizes the array when a collision occurs and hash is not full" do
      hash = OpenAddressing.new(4)
      #hash.print_status
      hash["key"] = "value"
      #hash.print_status
      expect(hash["key"]).to eq "value"
      expect(hash.get_size).to eq 4
      hash["key"] = "second value"
      #hash.print_status
      expect(hash["key"]).to eq "second value"
      expect(hash.get_size).to eq 4
      expect(hash["misnomer"]).to eq nil
    end

    it "resizes the array when a collision occurs and hash is full" do
      hash = OpenAddressing.new(1)
      hash["key"] = "value"
      #hash.print_status
      expect(hash.get_size).to eq 1
      hash["key"] = "second value"
      #hash.print_status
      expect(hash.get_size).to eq 2
    end

    it "sets the value of key to value" do
      expect(star_wars_movies["Star Wars: The Phantom Menace"]).to eq "Number One"
      expect(star_wars_movies["Star Wars: Attack of the Clones"]).to eq "Number Two"
      expect(star_wars_movies["Star Wars: Revenge of the Sith"]).to eq "Number Three"
      expect(star_wars_movies["Star Wars: A New Hope"]).to eq "Number Four"
      expect(star_wars_movies["Star Wars: The Empire Strikes Back"]).to eq "Number Five"
      expect(star_wars_movies["Star Wars: Return of the Jedi"]).to eq "Number Six"
    end
  end

  describe "#find_next_open_index" do
    it "returns nil if there are no open indices" do
      inception = OpenAddressing.new(1)
      inception["The Original"] = "The Best Movie Ever"
      expect(inception.find_next_open_index(0)).to eq (nil)
    end

  end

  describe "#resize" do
    it "doubles the size of the array when invoked" do
      movies = OpenAddressing.new(6)
      expect(movies.get_size).to eq 6
      movies.resize
      expect(movies.get_size).to eq 12
    end

    it "copies existing values properly when the array is resized" do
      movies = OpenAddressing.new(3)
      movies["A New Hope"] = "Average"
      movies["Empire Strikes Back"] = "Excellent"
      movies["Return of the Jedi"] = "The Best"
      movies["Star Wars: The Clone Wars"] = "Very Interesting"
      movies["Star Wars: The Force Awakens"] = "Amazing Reboot"
      movies["Star Wars: The Last Jedi"] = "Lots of Hype!"
      #movies.print_status
      movies["Star Wars: Episode IX"] = "Title TBD"
      #movies.print_status
      movies.resize
      #movies.print_status
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
