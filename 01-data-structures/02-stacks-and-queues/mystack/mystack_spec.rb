include RSpec

require_relative 'mystack'

RSpec.describe MyStack, type: Class do
  let(:stack) { MyStack.new }

  describe "#push" do
    it "pushes an item on top of the stack" do
      expect(stack.stack_length).to eq 0
      expect(stack.top).to eq nil
      stack.push("Rob")
      expect(stack.top).to eq "Rob"
      expect(stack.stack_length).to eq 1
    end

    it "pushes an item on top of the stack" do
      expect(stack.top).to eq nil
      expect(stack.stack_length).to eq 0
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
    it "pops an item off the top of the stack and returns it" do
      expect(stack.stack_length).to eq 0
      stack.push("Rob")
      stack.push("Ben")
      stack.push("Tim")
      stack.push("Jinhai")
      stack.push("Frank")

      expect(stack.top).to eq "Frank"
      expect(stack.stack_length).to eq 5
      item = stack.pop
      expect(item).to eq "Frank"
      expect(stack.top).to eq "Jinhai"
      expect(stack.stack_length).to eq 4
      item = stack.pop
      expect(item).to eq "Jinhai"
      item = stack.pop
      item = stack.pop
      item = stack.pop
      expect(stack.top).to eq nil
      expect(stack.stack_length).to eq 0
    end
  end

  describe "#empty?" do
    it "returns true when the stack is empty" do
      expect(stack.empty?).to eq true
    end

    it "returns false when the stack is not empty" do
      stack.push("Rob")
      expect(stack.empty?).to eq false
      stack.push("Ben")
      stack.push("Tim")
      stack.push("Jinhai")
      stack.push("Frank")
      expect(stack.empty?).to eq false
      item = stack.pop
      item = stack.pop
      item = stack.pop
      item = stack.pop
      item = stack.pop
      expect(stack.empty?).to eq true 
    end
  end
end
