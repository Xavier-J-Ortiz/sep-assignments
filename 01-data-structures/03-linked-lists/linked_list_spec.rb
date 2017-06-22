include RSpec

require_relative 'node'
require_relative 'linked_list'

RSpec.describe LinkedList, type: Class do
  let(:n1) { Node.new("Rob") }
  let(:n2) { Node.new("Ben") }
  let(:n3) { Node.new("Mike") }
  let(:n4) { Node.new("Vladimir") }
  let(:linked_list) { LinkedList.new }

  describe "#add_to_tail" do
    it "adds a Node to the tail" do
      linked_list.add_to_tail(n1)
      expect(linked_list.tail).to eq n1
      expect(linked_list.length).to eq 1
      linked_list.add_to_tail(n2)
      expect(linked_list.tail).to eq n2
      expect(linked_list.length).to eq 2
    end
  end

  describe "#remove_tail" do
    it "removes nodes from the tail" do
      linked_list.add_to_tail(n1)
      expect(linked_list.length).to eq 1
      linked_list.add_to_tail(n2)
      expect(linked_list.length).to eq 2
      expect(linked_list.tail).to eq n2
      linked_list.remove_tail
      expect(linked_list.length).to eq 1
      expect(linked_list.tail).to eq n1
      linked_list.remove_tail
      expect(linked_list.length).to eq 0
      expect(linked_list.tail).to eq nil
      linked_list.remove_tail
    end
  end

  describe "#print" do
    before do
      linked_list.add_to_tail(n1)
      expect(linked_list.length).to eq 1
      linked_list.add_to_tail(n2)
      expect(linked_list.length).to eq 2
      linked_list.add_to_tail(n3)
      expect(linked_list.length).to eq 3
    end
    specify { expect { linked_list.print }.to output("Rob\nBen\nMike\n").to_stdout }
  end

  describe "#delete" do
    before do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
    end

    it "removes the head of a list properly" do
      expect(linked_list.length).to eq 3
      linked_list.delete(n1)
      expect(linked_list.head).to eq n2
      expect(linked_list.head.next).to eq n3
      expect(linked_list.tail).to eq n3
      expect(linked_list.length).to eq 2
      linked_list.delete(n2)
      expect(linked_list.head).to eq n3
      expect(linked_list.head.next).to eq nil
      expect(linked_list.tail).to eq n3
      expect(linked_list.length).to eq 1
      linked_list.delete(n3)
      expect(linked_list.head).to eq nil 
      expect(linked_list.tail).to eq nil
      expect(linked_list.length).to eq 0
    end

    it "removes the middle element of a list properly" do
      linked_list.delete(n2)
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n1
      expect(linked_list.head.next).to eq n3
      expect(linked_list.tail).to eq n3
      linked_list.delete(n3)
      expect(linked_list.head).to eq n1
      expect(linked_list.head.next).to eq nil
      expect(linked_list.tail).to eq n1
      expect(linked_list.length).to eq 1
      linked_list.delete(n1)
      expect(linked_list.head).to eq nil 
      expect(linked_list.tail).to eq nil
      expect(linked_list.length).to eq 0
    end

    it "removes the last element of a list properly detects non-existing node" do
      linked_list.delete(n3)
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n1
      expect(linked_list.head.next).to eq n2
      expect(linked_list.tail).to eq n2
      linked_list.delete(n1)
      expect(linked_list.head).to eq n2
      expect(linked_list.head.next).to eq nil
      expect(linked_list.tail).to eq n2
      expect(linked_list.length).to eq 1
      linked_list.delete(n4)
      linked_list.delete(n2)
      expect(linked_list.head).to eq nil 
      expect(linked_list.tail).to eq nil
      expect(linked_list.length).to eq 0
    end
  end

  describe "#add_to_front" do
    it "adds the node to the front of the linked list" do
      linked_list.add_to_front(n1)
      expect(linked_list.length).to eq 1
      expect(linked_list.head).to eq n1
      linked_list.add_to_front(n2)
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n2
      linked_list.add_to_front(n3)
      expect(linked_list.length).to eq 3
      expect(linked_list.head).to eq n3
      expect(linked_list.tail).to eq n1
    end
  end

  describe "#remove_front" do
    it "removes the first node of the linked list" do
      linked_list.add_to_front(n1)
      expect(linked_list.length).to eq 1
      expect(linked_list.head).to eq n1
      linked_list.add_to_front(n2)
      expect(linked_list.length).to eq 2
      expect(linked_list.head).to eq n2
      linked_list.remove_front
      expect(linked_list.length).to eq 1
      expect(linked_list.head).to eq n1
      linked_list.remove_front
      expect(linked_list.length).to eq 0
      expect(linked_list.head).to eq nil
    end
  end

  describe "#locate_node_by_index" do
    before do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
    end

    it "locates nodes by index" do
      expect(linked_list.length).to eq 3
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Ben"
      expect(linked_list.locate_node_by_index(2).data).to eq "Mike"
      expect(linked_list.locate_node_by_index(-2)).to eq nil
      linked_list.delete(n2)
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Mike"
      linked_list.delete(n3)
      expect(linked_list.length).to eq 1
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      linked_list.delete(n1)
      expect(linked_list.length).to eq 0
      expect(linked_list.locate_node_by_index(0)).to eq nil

    end
  end
  describe "#delete_node_by_index" do
    before do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
    end

    it "deletes the node at the given index" do
      expect(linked_list.length).to eq 3
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Ben"
      expect(linked_list.locate_node_by_index(2).data).to eq "Mike"
      linked_list.delete_node_by_index(1) 
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Mike"
      linked_list.delete_node_by_index(0) 
      expect(linked_list.length).to eq 1
      expect(linked_list.locate_node_by_index(0).data).to eq "Mike" 
      linked_list.delete_node_by_index(0) 
      expect(linked_list.length).to eq 0
      expect(linked_list.locate_node_by_index(0)).to eq nil 
    end
  end

  describe "#locate_node_by_index" do
    before do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
    end

    it "checks for nil return on trying to locate an index that is out of bounds" do
      expect(linked_list.length).to eq 3
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Ben"
      expect(linked_list.locate_node_by_index(2).data).to eq "Mike"
      expect(linked_list.locate_node_by_index(5)).to eq nil
      linked_list.delete_node_by_index(1) 
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob"
      expect(linked_list.locate_node_by_index(1).data).to eq "Mike"
      expect(linked_list.locate_node_by_index(2)).to eq nil
      linked_list.delete_node_by_index(0) 
      expect(linked_list.length).to eq 1
      expect(linked_list.locate_node_by_index(0).data).to eq "Mike" 
    end
  end

describe "#find_node_prior" do
    before do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
    end

    it "" do
      expect(linked_list.length).to eq 3
      expect(linked_list.find_node_prior(n3, false).data).to eq "Ben"
      expect(linked_list.find_node_prior(n2, false).data).to eq "Rob"
    end
  end


  describe "#delete_next_node" do
    before do
      linked_list.add_to_tail(n1)
      linked_list.add_to_tail(n2)
      linked_list.add_to_tail(n3)
    end

    it "checks for nil return on trying to locate an index that is out of bounds" do
      expect(linked_list.length).to eq 3
      linked_list.delete_next_node(n1)
      expect(linked_list.length).to eq 2
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob" 
      expect(linked_list.locate_node_by_index(1).data).to eq "Mike" 
      expect(linked_list.locate_node_by_index(2)).to eq nil 
      linked_list.delete_next_node(n2)
      expect(linked_list.length).to eq 1
      expect(linked_list.locate_node_by_index(0).data).to eq "Rob" 
      expect(linked_list.locate_node_by_index(2)).to eq nil 
    end
  end
end
