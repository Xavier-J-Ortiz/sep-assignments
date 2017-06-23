include RSpec

require_relative 'node'
require_relative 'linked_list'

RSpec.describe LinkedList, type: Class do
  let(:n1) { Node.new("Rob") }
  let(:n2) { Node.new("Ben") }
  let(:n3) { Node.new("Mike") }
  let(:n4) { Node.new("Vladimir") }
  let(:linked_list) { LinkedList.new }

  def pusher
    linked_list.add_to_tail(n1)
    linked_list.add_to_tail(n2)
    linked_list.add_to_tail(n3)
  end

  describe "#add_to_tail" do
    it "adds a Node to linked_list via add_to_tail" do
      linked_list.add_to_tail(n1)
      expect(linked_list.head).to eq n1
      expect(linked_list.tail).to eq n1
      expect(linked_list.length).to eq 1
    end

    it "adds 2 Nodes to linked_list via add_to_tail" do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      expect(linked_list.head).to eq n1
      expect(linked_list.tail).to eq n2
      expect(linked_list.length).to eq 2
    end

    it "adds 3 Nodes to linked_list via add_to_tail" do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
      expect(linked_list.head).to eq n1
      expect(linked_list.tail).to eq n3
      expect(linked_list.length).to eq 3
    end
  end

  describe "#remove_tail" do
    before do
      pusher
    end

    it "removes a single node from the tail" do
      linked_list.remove_tail
      expect(linked_list.length).to eq 2
      expect(linked_list.tail).to eq n2
    end

    it "removes a two nodes from the tail" do
      linked_list.remove_tail
      linked_list.remove_tail
      expect(linked_list.length).to eq 1
      expect(linked_list.tail).to eq n1
    end

    it "removes a three nodes from the tail" do
      linked_list.remove_tail
      linked_list.remove_tail
      linked_list.remove_tail
      expect(linked_list.length).to eq 0
      expect(linked_list.tail).to eq nil
    end
  end

  describe "#print" do
    before do
      pusher
    end

    specify { expect { linked_list.print }.to output("Rob\nBen\nMike\n").to_stdout }
  end

  describe "#delete" do
    before do
      pusher
    end

    it "removes the head of a list properly" do
      linked_list.delete(linked_list.head)
      expect(linked_list.head).to eq n2
      expect(linked_list.head.next).to eq n3
      expect(linked_list.tail).to eq n3
      expect(linked_list.length).to eq 2
    end

    it "removes the second element of a list properly" do
      linked_list.delete(n2)
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n1
      expect(linked_list.head.next).to eq n3
      expect(linked_list.tail).to eq n3
    end

    it "removes the tail element of a list properly detects non-existing node" do
      linked_list.delete(linked_list.tail)
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n1
      expect(linked_list.head.next).to eq n2
      expect(linked_list.tail).to eq n2
    end
  end

  describe "#add_to_front" do
    it "adds a single node to the front of the linked list" do
      linked_list.add_to_front(n1)
      expect(linked_list.length).to eq 1
      expect(linked_list.head).to eq n1
      expect(linked_list.tail).to eq n1
    end

    it "adds two nodes to the front of the linked list" do
      linked_list.add_to_front(n1)
      linked_list.add_to_front(n2)
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n2
      expect(linked_list.tail).to eq n1
    end

    it "adds three node to the front of the linked list" do
      linked_list.add_to_front(n1)
      linked_list.add_to_front(n2)
      linked_list.add_to_front(n3)
      expect(linked_list.length).to eq 3
      expect(linked_list.head).to eq n3
      expect(linked_list.tail).to eq n1
    end
  end

  describe "#remove_front" do
    it "removes the first node of the linked list" do
      linked_list.add_to_tail(n1)
      linked_list.remove_front
      expect(linked_list.length).to eq 0
      expect(linked_list.head).to eq nil
      expect(linked_list.tail).to eq nil
    end

    it "removes the first node of the linked list" do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.remove_front
      expect(linked_list.length).to eq 1
      expect(linked_list.head).to eq n2
      expect(linked_list.tail).to eq n2
    end

    it "removes the first node of the linked list" do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
      linked_list.remove_front
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n2
      expect(linked_list.tail).to eq n3
    end
  end

  describe "#delete_node_by_index" do
    before do
      pusher
    end

    it "deletes the first node in the list" do
      linked_list.delete_node_by_index(0) 
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Ben"
      expect(linked_list.locate_node_by_index(1).data).to eq "Mike"
    end

    it "deletes the second node in the list" do
      linked_list.delete_node_by_index(1) 
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Mike"
    end

    it "deletes the last node in the list" do
      linked_list.delete_node_by_index(2) 
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Ben"
    end
  end

  describe "#locate_node_by_index" do
    before do
      pusher
    end

    it "finds node by index" do
      expect(linked_list.locate_node_by_index(1).data).to eq "Ben"
    end

    it "returns nil if index is a positive integer out of bounds" do
      expect(linked_list.locate_node_by_index(5)).to eq nil
    end

    it "returns nil if index is a negative integer out of bounds" do
      expect(linked_list.locate_node_by_index(-3)).to eq nil
    end
  end

  describe "#find_node_prior" do
    before do
      pusher
    end

    it "can locate tail's previous node" do
      expect(linked_list.find_node_prior(linked_list.tail).data).to eq "Ben"
    end

    it "can locate the specified node's previous node" do
      expect(linked_list.find_node_prior(n2).data).to eq "Rob"
    end

    it "returns nil if searching for the node and it's not found" do
      expect(linked_list.find_node_prior(linked_list.head)).to eq nil
    end
  end

  describe "#delete_next_node" do
    before do
      pusher
    end

    it "deletes next node specified" do
      linked_list.delete_next_node(n1)
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob" 
      expect(linked_list.locate_node_by_index(1).data).to eq "Mike" 
      expect(linked_list.locate_node_by_index(2)).to eq nil 
    end

    it "returns nil if next node doesn't exist" do
      expect(linked_list.delete_next_node(n3)).to eq nil
    end
  end
end
