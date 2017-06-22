include RSpec

require_relative 'myqueue'

RSpec.describe MyQueue, type: Class do
  let(:q) { MyQueue.new }

  describe "#enqueue" do

    it "updates the head and tail accessors properly" do
      q.enqueue("Rob")
      expect(q.head).to eq "Rob"
      expect(q.tail).to eq "Rob"
      q.enqueue("Ben")
      expect(q.head).to eq "Rob"
      expect(q.tail).to eq "Ben"
      q.enqueue("Jim")
      expect(q.head).to eq "Rob"
      expect(q.tail).to eq "Jim"
    end

    it "adds an item to the end the queue" do
      q.enqueue("Rob")
      expect(q.head).to eq "Rob"
      expect(q.tail).to eq "Rob"
      q.enqueue("Ben")
      expect(q.head).to eq "Rob"
      expect(q.tail).to eq "Ben"
      q.enqueue("Jim")
      expect(q.head).to eq "Rob"
      expect(q.tail).to eq "Jim"
    end
  end

  describe "#empty?" do
    it "returns true if the queue is empty" do
      expect(q.empty?).to eq true
    end

    it "returns false if the queue is not empty" do
      q.enqueue("Rob")
      expect(q.empty?).to eq false
    end
  end

  describe "#dequeue" do
    it "removes an item from the front of the queue that has one element" do
      q.enqueue("Rob")
      expect(q.empty?).to eq false
      q.dequeue
      expect(q.empty?).to eq true
    end

    it "removes an item from the front of the queue with 3 elements" do
      q.enqueue("Rob")
      q.enqueue("Ben")
      q.enqueue("Jim")
      q.dequeue
      expect(q.head).to eq "Ben"
      expect(q.tail).to eq "Jim"
      expect(q.empty?).to eq false
    end
    
    it "removes an item from the front of the queue with 2 elements" do
      q.enqueue("Ben")
      q.enqueue("Jim")
      q.dequeue
      expect(q.head).to eq "Jim"
      expect(q.tail).to eq "Jim"
      expect(q.empty?).to eq false
    end
    it "removes an item from the front of the queue with 1 element" do
      q.enqueue("Jim")
      q.dequeue
      expect(q.head).to eq nil
      expect(q.tail).to eq nil
      expect(q.empty?).to eq true
    end
  end
end
