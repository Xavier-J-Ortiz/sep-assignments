include RSpec

require_relative 'mystack'

RSpec.describe MyStack, type: Class do
  let(:stack) { MyStack.new }

  describe "#push" do
    it "pushes a single item and checks the top of the stack stack height" do
      stack.push("Rob")
      expect(stack.top).to eq "Rob"
    end

    it "pushes 5 items and checks the top of the stack and stack height" do
      stack.push("Rob")
      expect(stack.top).to eq "Rob"
      expect(stack.stack_length).to eq 1

      stack.push("Ben")
      expect(stack.top).to eq "Ben"
      expect(stack.stack_length).to eq 2

      stack.push("Tim")
      expect(stack.top).to eq "Tim"
      expect(stack.stack_length).to eq 3

      stack.push("Jinhai")
      expect(stack.top).to eq "Jinhai"
      expect(stack.stack_length).to eq 4

      stack.push("Frank")
      expect(stack.top).to eq "Frank"
      expect(stack.stack_length).to eq 5
    end
  end

  describe "#pop" do

    before do
      stack.push("Rob")
      stack.push("Ben")
      stack.push("Tim")
      stack.push("Jinhai")
      stack.push("Frank")
    end

    it "pops an item off the top of the stack and returns it" do
      item = stack.pop
      expect(item).to eq "Frank"

      item = stack.pop
      expect(item).to eq "Jinhai"

      item = stack.pop
      expect(item).to eq "Tim"

      item = stack.pop
      expect(item).to eq "Ben"

      item = stack.pop
      expect(item).to eq "Rob"
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
        stack.push("Rob")
        stack.push("Ben")
        stack.push("Tim")
        stack.push("Jinhai")
        stack.push("Frank")
      end

      it "returns false if stack is not empty, returns true if stack is empty" do
        expect(stack.empty?).to eq false

        stack.pop
        expect(stack.empty?).to eq false

        stack.pop
        expect(stack.empty?).to eq false

        stack.pop
        expect(stack.empty?).to eq false

        stack.pop
        expect(stack.empty?).to eq false

        stack.pop
        expect(stack.empty?).to eq true 
      end
    end
  end
end
