include RSpec

require_relative 'separate_chaining'

RSpec.describe SeparateChaining, type: Class do
  let(:star_wars_movies) { SeparateChaining.new(6) }

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

  describe "#key" do
    it "returns the sum of the ascii values of the string value" do
      key = "test"
      expect(star_wars_movies.index(key, 6)).to eq 4
    end
  end

  describe "#hash[key] = value" do
    it "does not resize the array when a collision occurs and the values match" do
      hash = SeparateChaining.new(4)
      hash["key"] = "value"
      #hash.print_status
      expect(hash.get_size).to eq 4
      hash["key"] = "second value"
      #hash.print_status
      expect(hash.get_size).to eq 4
    end

    it "sets the value of key to value" do
      star_wars_movies["Star Wars: The Phantom Menace"] = "Number One"
      star_wars_movies["Star Wars: Attack of the Clones"] = "Number Two"
      star_wars_movies["Star Wars: Revenge of the Sith"] = "Number Three"
      star_wars_movies["Star Wars: A New Hope"] = "Number Four"
      star_wars_movies["Star Wars: The Empire Strikes Back"] = "Number Five"
      star_wars_movies["Star Wars: Return of the Jedi"] = "Number Six"

      expect(star_wars_movies["Star Wars: The Phantom Menace"]).to eq "Number One"
      expect(star_wars_movies["Star Wars: Attack of the Clones"]).to eq "Number Two"
      expect(star_wars_movies["Star Wars: Revenge of the Sith"]).to eq "Number Three"
      expect(star_wars_movies["Star Wars: A New Hope"]).to eq "Number Four"
      expect(star_wars_movies["Star Wars: The Empire Strikes Back"]).to eq "Number Five"
      expect(star_wars_movies["Star Wars: Return of the Jedi"]).to eq "Number Six"
    end
  end

  describe "#load_factor" do
    it "returns the number of items in the hash divided by the size of the underlying array" do
      h = SeparateChaining.new(4)
      #h.print_status

      expect(h.load_factor == 0).to be true
      h["key"] = "value"
      h["keytwo"] = "valve"
      #h.print_status

      expect(h.load_factor).to eq 0.5
      h["keythree"] = "banue"
      #h.print_status

      expect(h.load_factor).to eq 0.375
    end
  end

  describe "#resize" do
    it "doubles the size of the array when invoked" do
      movies = SeparateChaining.new(6)
      expect(movies.get_size).to eq 6
      movies.resize
      expect(movies.get_size).to eq 12
    end

    it "copies existing values properly when the array is resized" do
      movies = SeparateChaining.new(3)
      movies["A New Hope"] = "Average"
      movies["Empire Strikes Back"] = "Excellent"
      movies["Return of the Jedi"] = "The Best"
      movies["Star Wars: The Clone Wars"] = "Very Interesting"
      movies["Star Wars: The Force Awakens"] = "Amazing Reboot"
      movies["Star Wars: The Last Jedi"] = "Lots of Hype!"
      movies["Star Wars: Episode IX"] = "Title TBD"
      movies["Star Wars: Magazines"] = "Don't Count"
      movies["Star Wars: Fan Fiction"] = "Can Get Sued"
      #movies.print_status
      expect(movies["Return of the Jedi"]).to eq "The Best"
      expect(movies["Empire Strikes Back"]).to eq "Excellent"
      expect(movies["A New Hope"]).to eq "Average"
      expect(movies["Star Wars: The Clone Wars"]).to eq "Very Interesting"
      expect(movies["Star Wars: The Force Awakens"]).to eq "Amazing Reboot"
      expect(movies["Star Wars: The Last Jedi"]).to eq "Lots of Hype!"
      expect(movies["Star Wars: Episode IX"]).to eq "Title TBD"
      expect(movies["Star Wars: Magazines"]).to eq "Don't Count"
      expect(movies["Star Wars: Fan Fiction"]).to eq "Can Get Sued"
      movies.resize
      expect(movies.get_size).to eq 48 
      #movies.print_status
      expect(movies["A New Hope"]).to eq "Average"
      expect(movies["Empire Strikes Back"]).to eq "Excellent"
      expect(movies["Return of the Jedi"]).to eq "The Best"
      expect(movies["Star Wars: The Clone Wars"]).to eq "Very Interesting"
      expect(movies["Star Wars: The Force Awakens"]).to eq "Amazing Reboot"
      expect(movies["Star Wars: The Last Jedi"]).to eq "Lots of Hype!"
      expect(movies["Star Wars: Episode IX"]).to eq "Title TBD"
      expect(movies["Star Wars: Magazines"]).to eq "Don't Count"
      expect(movies["Star Wars: Fan Fiction"]).to eq "Can Get Sued"
    end
  end
end
