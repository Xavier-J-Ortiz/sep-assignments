include RSpec

require_relative 'node'
require_relative 'movie'
require_relative 'kb_finder'

RSpec.describe Node, type: Class do
  let(:clooney) { Node.new("George Clooney") }

  describe "#initialize" do
    it "creates brand new node correctly" do
      expect(clooney.name).to eq "George Clooney"
    end
    it "creates an empty film actor hash" do
      expect(clooney.film_actor_hash.empty?).to eq true
    end
  end
end
