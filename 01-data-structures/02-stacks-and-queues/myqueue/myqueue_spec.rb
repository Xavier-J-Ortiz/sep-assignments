include RSpec

require_relative 'myqueue'

RSpec.describe MyQueue, type: Class do
  let(:q) { MyQueue.new }

  describe "#enqueue" do
    it "enqueues strings to the queue, verifies with head and tail" do
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
    before do
      q.enqueue("Rob")
      q.enqueue("Ben")
      q.enqueue("Jim")
    end

    it "removes an item from the front of the queue" do
      q.dequeue
      expect(q.head).to eq "Ben"
      expect(q.tail).to eq "Jim"
      expect(q.empty?).to eq false
    end

    it "removes items from the front of the queue leaving one element" do
      q.dequeue
      q.dequeue
      expect(q.head).to eq "Jim"
      expect(q.tail).to eq "Jim"
      expect(q.empty?).to eq false
    end

    it "removes all items from the queue" do
      q.dequeue
      q.dequeue
      q.dequeue
      expect(q.head).to eq nil
      expect(q.tail).to eq nil
      expect(q.empty?).to eq true
    end
  end
end
