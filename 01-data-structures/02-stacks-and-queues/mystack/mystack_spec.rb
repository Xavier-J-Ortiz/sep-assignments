include RSpec

require_relative 'mystack'

RSpec.describe MyStack, type: Class do
  let(:stack) { MyStack.new }

  def pusher
    stack.push("Rob")
    stack.push("Ben")
    stack.push("Tim")
    stack.push("Jinhai")
    stack.push("Frank")
  end

  describe "#push" do
    it "pushes a single item" do
      stack.push("Rob")
      expect(stack.top).to eq "Rob"
      expect(stack.stack_length).to eq 1
    end
 end

  describe "#pop" do
    before do
      pusher
    end

    it "pops an item off the top of the stack" do
      item = stack.pop
      expect(item).to eq "Frank"
      expect(stack.top).to eq "Jinhai"
      expect(stack.stack_length).to eq 4
    end
  end

  describe "#empty?" do
    context "when stack is initialized" do
      it "returns true" do
        expect(stack.empty?).to eq true
      end
    end

    context "when stack has multiple items loaded" do
      before do
        stack.push("Jinhai")
      end

      it "returns true if stack is empty" do
        stack.pop
        expect(stack.empty?).to eq true 
      end

      it "returns false if stack is not empty" do
        expect(stack.empty?).to eq false
      end
    end
  end
end
