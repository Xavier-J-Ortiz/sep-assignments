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
  let(:freeman) { Node.new("Morgan Freeman") }
  let(:pitt) { Node.new("Brad Pitt") }
  let(:paltrow) { Node.new("Gwyneth Paltrow") }
  let(:blanchett) { Node.new("Cate Blanchett") }
  let(:swinton) { Node.new("Tilda Swinton") }
  let(:wood) { Node.new("Elija Wood") }
  let(:mckellen) { Node.new("Ian McKellen") }
  let(:bloom) { Node.new("Kevin Bacon") }
  let(:stallone) { Node.new("Sylvester Stallone") }
  let(:schwarzenegger) { Node.new("Arnold Schwarzenegger") }
  let(:couture) { Node.new("Randy Couture") }
  let(:hamilton) { Node.new("Linda Hamilton") }
  let(:furlong) { Node.new("Edward Furlong") }
  let(:norton) { Node.new("Edward Norton") }
  let(:gere) { Node.new("Richard Gere") }
  let(:connery) { Node.new("Sean Connery") }
  let(:ormond) { Node.new("Julia Ormond") }
  let(:tierney) { Node.new("Maura Tierney") }
  let(:lithgow) { Node.new("John Lithgow") }

  describe "#find_kevin_bacon" do
    before do
      @first_knight = Movie.new("First Knight", [ormond, gere, connery])
      @primal_fear = Movie.new("Primal Fear", [gere, norton, tierney])
      @american_history_x = Movie.new("American History X", [furlong, norton])
      @terminator_2 = Movie.new("Terminator 2: Judgement Day", [schwarzenegger, hamilton, furlong])
      @expendibles_2 = Movie.new("The Expendibles 2", [lhemsworth, couture, stallone])
      @expendibles = Movie.new("The Expendibles", [stallone, schwarzenegger])
      @hunger = Movie.new("The Hunger Games", [jlaw, lhemsworth, hutcherson])
      @first_class = Movie.new("X-Men: First Class", [mcavoy, fassbender, jlaw, bacon])
      @se7en = Movie.new("Se7en", [pitt, freeman, paltrow])
      @button = Movie.new("The Curious Case of Benjamin Button", [pitt, blanchett, swinton])
      @lotr = Movie.new("The Lord of the Rings: The Fellowship of the Ring", [wood, mckellen, bloom])
    end

    it "returns an empty array if the node is Kevin Bacon" do
      expect(find_kevin_bacon(bacon)).to eq []
    end

    it "finds kevin bacon with a distance less than 7" do
      expect(find_kevin_bacon(norton)).to eq ["American History X", "Terminator 2: Judgement Day", "The Expendibles", "The Expendibles 2", "The Hunger Games", "X-Men: First Class"]
    end

    it "returns nil if distance to kevin bacon is greater than 6" do
      expect(find_kevin_bacon(tierney)).to eq nil
    end
  end

  describe "#trace_path" do
    context "When Kevin Bacon is reached via John Lithgow"
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

    it "returns degrees of separation between original actor and Kevin Bacon" do
      expect(trace_path("Footloose", @path, lithgow)).to eq ["Shrek", "Footloose"]
    end
  end
end
