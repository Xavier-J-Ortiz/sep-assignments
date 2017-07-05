include RSpec
require_relative 'min_binary_heap'

RSpec.describe MinBinaryHeap, type: Class do

  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:matrix) { Node.new("The Matrix", 87) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }
  let(:root) { braveheart }

  let (:tree) { MinBinaryHeap.new(braveheart) }

  describe "#insert(data)" do
    context "simple heap inserted in size order" do
      before do
        tree.insert(root, donnie)
        tree.insert(root, jedi)
        tree.insert(root, inception)
        tree.insert(root, matrix)
        tree.insert(root, district)
        tree.insert(root, martian)
      end
      it "properly inserts a new node as a left child" do
        expect(root.left.title).to eq donnie.title 
      end

      it "properly inserts a new node as a left-left child" do
        expect(root.left.left.title).to eq inception.title 
      end

      it "properly inserts a new node as a left-right child" do
        expect(root.left.right.title).to eq matrix.title
      end

      it "properly inserts a new node as a right child" do
        expect(root.right.title).to eq jedi.title
      end

      it "properly inserts a new node as a right-left child" do
        expect(root.right.left.title).to eq district.title
      end

      it "properly inserts a new node as a right-right child" do
        expect(root.right.right.title).to eq martian.title
      end
    end
    context "test if one or more parent-child swaps ocurr if an inserted node.rating is smaller than it's parent.rating" do
      before do
        tree.insert(root, inception)
        tree.insert(root, matrix)
      end

      it "inserted node takes the place of the left node" do
        tree.insert(root, donnie)
        expect(root.left.title).to eq donnie.title
        expect(root.left.left.title).to eq inception.title
      end
      it "inserted node takes the place of the left node" do
        tree.insert(root, district)
        tree.insert(root, donnie)
        expect(root.left.title).to eq donnie.title
        expect(root.left.right.title).to eq inception.title
      end
      it "inserted node takes the place of the right node" do
        tree.insert(root, district)
        tree.insert(root, martian)
        tree.insert(root, donnie)
        expect(root.right.title).to eq donnie.title
        expect(root.right.left.title).to eq matrix.title
      end
      it "inserted node takes the place of the right node" do
        tree.insert(root, district)
        tree.insert(root, martian)
        tree.insert(root, hope)
        tree.insert(root, donnie)
        expect(root.right.title).to eq donnie.title
        expect(root.right.right.title).to eq matrix.title
      end
      it "inserted node replaces the root node" do
        tree.insert(root, pacific_rim)
        expect(root.title).to eq pacific_rim.title
        expect(root.left.title).to eq inception.title
        expect(root.right.title).to eq matrix.title
      end
    end
  end

  describe "#find(data)" do
    before do
      tree.insert(root, donnie)
      tree.insert(root, jedi)
      tree.insert(root, inception)
      tree.insert(root, matrix)
      tree.insert(root, district)
      tree.insert(root, martian)
    end
    it "handles nil gracefully" do
      found_node = tree.find(root, empire)
      expect(found_node).to eq nil
    end

    it "properly finds a left node" do
      found_node = tree.find(root, donnie)
      expect(found_node.title).to eq donnie.title
    end

    it "properly finds a left-left node" do
      found_node = tree.find(root, inception)
      expect(found_node.title).to eq inception.title
    end

    it "properly finds a left-right node" do
      found_node = tree.find(root, matrix)
      expect(found_node.title).to eq matrix.title
    end

    it "properly finds a right node" do
      found_node = tree.find(root, jedi)
      expect(found_node.title).to eq jedi.title
    end

    it "properly finds a right-left node" do
      found_node = tree.find(root, district)
      expect(found_node.title).to eq district.title
    end

    it "properly finds a right-right node" do
      found_node = tree.find(root, martian)
      expect(found_node.title).to eq martian.title
    end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
    end

    it "properly deletes a left node" do
    end

    it "properly deletes a left-left node" do
    end

    it "properly deletes a left-right node" do
    end

    it "properly deletes a right node" do
    end

    it "properly deletes a right-left node" do
    end

    it "properly deletes a right-right node" do
    end
  end
end
=begin
  describe "#printf" do
     specify {
       expected_output = "The Matrix: 87\nStar Wars: Return of the Jedi: 80\nStar Wars: A New Hope: 93\nPacific Rim: 72\nInception: 86\nThe Martian: 92\nStar Wars: The Empire Strikes Back: 94\nBraveheart: 78\nThe Shawshank Redemption: 91\nMad Max 2: The Road Warrior: 98\nDistrict 9: 90\n"
       tree.insert(root, hope)
       tree.insert(root, empire)
       tree.insert(root, jedi)
       tree.insert(root, martian)
       tree.insert(root, pacific_rim)
       tree.insert(root, inception)
       tree.insert(root, braveheart)
       tree.insert(root, shawshank)
       tree.insert(root, district)
       tree.insert(root, mad_max_2)
       expect { tree.printf }.to output(expected_output).to_stdout
     }

     specify {
       expected_output = "The Matrix: 87\nBraveheart: 78\nMad Max 2: The Road Warrior: 98\nPacific Rim: 72\nInception: 86\nDistrict 9: 90\nStar Wars: Return of the Jedi: 80\nThe Shawshank Redemption: 91\nThe Martian: 92\nStar Wars: The Empire Strikes Back: 94\nStar Wars: A New Hope: 93\n"
       tree.insert(root, mad_max_2)
       tree.insert(root, district)
       tree.insert(root, shawshank)
       tree.insert(root, braveheart)
       tree.insert(root, inception)
       tree.insert(root, pacific_rim)
       tree.insert(root, martian)
       tree.insert(root, jedi)
       tree.insert(root, empire)
       tree.insert(root, hope)
       expect { tree.printf }.to output(expected_output).to_stdout
     }
  end
=end

