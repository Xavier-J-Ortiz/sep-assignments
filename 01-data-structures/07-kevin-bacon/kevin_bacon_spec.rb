include RSpec

require_relative 'node'
require_relative 'movie'
require_relative 'kb_finder'

RSpec.describe "kb_finder" do

  let(:bacon) { Node.new("Kevin Bacon") }
  let(:mcavoy) { Node.new("James McAvoy") }
  let(:fassbender) { Node.new("Michael Fassbender") }
  let(:jlaw) { Node.new("Jennifer Lawrence") }
  let(:lhemsworth) { Node.new("Liam Hemsworth") }
  let(:hutcherson) { Node.new("Josh Hutcherson") }
  let(:stallone) { Node.new("Sylvester Stallone") }
  let(:schwarzenegger) { Node.new("Arnold Schwarzenegger") }
  let(:couture) { Node.new("Randy Couture") }
  let(:hamilton) { Node.new("Linda Hamilton") }
  let(:furlong) { Node.new("Edward Furlong") }
  let(:norton) { Node.new("Edward Norton") }
  let(:gere) { Node.new("Richard Gere") }
  let(:tierney) { Node.new("Maura Tierney") }
  let(:lithgow) { Node.new("John Lithgow") }
  let(:jackman) { Node.new("Hugh Jackman") }
  let(:fraiser) { Node.new("Brandon Fraiser") }
  let(:kidman) { Node.new("Nicole Kidman") }
  let(:johnson) { Node.new("Dwayne Johnson") }
  let(:ortiz) {Node.new("Xavier Ortiz")}

  describe "#find_kevin_bacon" do
    before do
      @primal_fear = Movie.new("Primal Fear", [gere, norton, tierney])
      @american_history_x = Movie.new("American History X", [furlong, norton])
      @terminator_2 = Movie.new("Terminator 2: Judgement Day", [schwarzenegger, hamilton, furlong])
      @expendibles_2 = Movie.new("The Expendibles 2", [lhemsworth, couture, stallone])
      @expendibles = Movie.new("The Expendibles", [stallone, schwarzenegger])
      @hunger = Movie.new("The Hunger Games", [jlaw, lhemsworth, hutcherson])
      @first_class = Movie.new("X-Men: First Class", [mcavoy, fassbender, jlaw, bacon])
      
      @dead_end_1 = Movie.new("DE1", [jackman, johnson])
      @dead_end_2 = Movie.new("DE2", [fraiser, johnson])
      @dead_end_3 = Movie.new("DE3", [fraiser, kidman])
    end

    it "returns an empty array if the node is Kevin Bacon" do
      expect(find_kevin_bacon(bacon)).to eq []
    end

    it "finds kevin bacon with a maximum distance of 6 " do
      expect(find_kevin_bacon(norton)).to eq ["American History X", "Terminator 2: Judgement Day", "The Expendibles", "The Expendibles 2", "The Hunger Games", "X-Men: First Class"]
    end

    it "returns nil if distance to kevin bacon is greater than 6" do
      expect(find_kevin_bacon(tierney)).to eq nil
    end

    it "returns nil if there is no connection to Kevin Bacon" do
      expect(find_kevin_bacon(jackman)).to eq nil
    end
    
    it "returns nil if an actor node is not in any movies" do
      expect(find_kevin_bacon(ortiz)).to eq nil
    end
  end

  describe "#trace_movies_to_kevin" do
    before do
      @path = {}
      @path["Mike Meyers"] = {:distance =>  0,
                              :previous_node => nil, 
                              :encountered_movie => nil}
      @path["John Lithgow"] = {:distance =>  1,
                               :previous_node => @path["Mike Meyers"],
                               :encountered_movie => "Shrek"}
      @path["Kevin Bacon"] = {:distance =>  2, 
                              :previous_node => @path["John Lithgow"], 
                              :encountered_movie => "Footloose"}
    end

    it "helper method returns array of movies between lithgow and Kevin Bacon" do
      expect(trace_movies_to_kevin("Footloose", @path, lithgow)).to eq ["Shrek", "Footloose"]
    end
  end
end
