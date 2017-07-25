include RSpec
require_relative 'node'
require_relative 'movie'
RSpec.describe Movie, type: Class do
  let(:stallone) { Node.new("Sylvester Stallone") }
  let(:schwarzenegger) { Node.new("Arnold Schwarzenegger") }
  let(:carrey) { Node.new("Jim Carrey") }
  describe "#initalize" do
    before do
      @expendibles = Movie.new("The Expendibles", [stallone, schwarzenegger])
    end
    it "movie title associated correctly" do
      expect(@expendibles.title).to eq "The Expendibles"
    end

    it "movie actors associated correctly" do 
      expect(@expendibles.actors).to eq [stallone, schwarzenegger]
    end
  end

  describe "#format_actors_array_for_each_actor_node" do
    before do
      @test_movie = Movie.new("Test Movie", [stallone, carrey, schwarzenegger])
    end
    it "assigns a properly formatted actors array to the film_actor_hash of an actor node" do
      expect(stallone.film_actor_hash["Test Movie"]).to eq [carrey, schwarzenegger]
      expect(schwarzenegger.film_actor_hash["Test Movie"]).to eq [stallone, carrey]
      expect(carrey.film_actor_hash["Test Movie"]).to eq [stallone, schwarzenegger]
    end
  end
end

