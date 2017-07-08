include RSpec

require_relative 'hash_item'
require_relative 'hashclass'

RSpec.describe HashClass, type: Class do
  let(:lotr_movies) { HashClass.new(6) }

  describe "#index" do
    it "creates a hash key based on the string value passed in" do
      i = lotr_movies.index("The Lord of the Rings: The Fellowship of the Ring", 6)
      expect(i).to eq 5
    end
  end

  describe "#get_size" do
    it "verifies the hash size" do
      expect(lotr_movies.get_size).to eq 6
    end
  end

  describe "#[]=" do
    it "adds a key, value pair to the hash" do
      lotr_movies["test"] = "forever"
      expect(lotr_movies["test"]).to eq "forever"
    end
  end

  describe "#[]" do
    before do
      lotr_movies["The Lord of the Rings: The Fellowship of the Ring"] = "Boring!"
    end

    it "finds a value by specifying the key in a hash" do
      expect(lotr_movies["The Lord of the Rings: The Fellowship of the Ring"]).to eq "Boring!"
    end
  end

  describe "#print_status" do
    hash = HashClass.new(1)

    it "prints size and hash state"do
      expect {hash["key"] = "value"}.to output("\nthe array size is: 1\nthe array state is :\n{\n\t'key' : 'value',\n}\n").to_stdout
    end
  end

  describe "#resize" do
    it "doubles the size of the array when invoked" do
      expect(lotr_movies.get_size).to eq 6
      lotr_movies.resize
      expect(lotr_movies.get_size).to eq 12
    end

    it "copies existing values properly when the array is resized" do
      movies = HashClass.new(30)
      movies["A New Hope"] = "Average"
      movies["Empire Strikes Back"] = "Excellent"
      movies["Return of the Jedi"] = "The Best"
      movies.resize
      expect(movies.get_size).to eq 60
      expect(movies["A New Hope"]).to eq "Average"
      expect(movies["Empire Strikes Back"]).to eq "Excellent"
      expect(movies["Return of the Jedi"]).to eq "The Best"
    end
  end

  describe "hash[key] = value" do
    hash = HashClass.new(1)

    it "prints size and hash state"do
      expect {hash["key"] = "value"}.to output("\nthe array size is: 1\nthe array state is :\n{\n\t'key' : 'value',\n}\n").to_stdout
    end

    it "does not resize the array when a collision occurs and the values match" do
      hash["key"] = "value"
      expect(hash.get_size).to eq 1
    end

    it "resizes the array when a collision occurs and the values do not match" do
      hash["key"] = "different"
      expect(hash.get_size).to eq 2
    end
    before do 
    end

    before do
      lotr_movies["The Lord of the Rings: The Fellowship of the Ring"] = "3 hours, 48 minutes"
      lotr_movies["The Lord of the Rings: The Two Towers"] = "3 hours, 55 minutes"
      lotr_movies["The Lord of the Rings: The Return of the King"] = "3 hours, 21 minutes"
      lotr_movies["The Hobbit: An Unexpected Journey"] = "3 hours, 2 minutes"
      lotr_movies["The Hobbit: The Desolation of Smaug"] = "3 hours, 7 minutes"
      lotr_movies["The Hobbit: The Battle of Five Armies"] = "2 hours, 44 minutes"
    end

    it "adding multiple values correctly saves them within the hash" do
      expect(lotr_movies["The Lord of the Rings: The Fellowship of the Ring"]).to eq "3 hours, 48 minutes"
      expect(lotr_movies["The Lord of the Rings: The Two Towers"]).to eq "3 hours, 55 minutes"
      expect(lotr_movies["The Lord of the Rings: The Return of the King"]).to eq "3 hours, 21 minutes"
      expect(lotr_movies["The Hobbit: An Unexpected Journey"]).to eq "3 hours, 2 minutes"
      expect(lotr_movies["The Hobbit: The Desolation of Smaug"]).to eq "3 hours, 7 minutes"
      expect(lotr_movies["The Hobbit: The Battle of Five Armies"]).to eq "2 hours, 44 minutes"
    end

    it "correctly increases the internal hash size array to compenesate for any collisions." do
      expect(lotr_movies.get_size).not_to eq 6
    end
  end
end
