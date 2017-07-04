include RSpec
require_relative 'min_binary_heap'

RSpec.describe MinBinaryHeap , type: Class do
  let (:root) { Node.new("The Matrix", 87) }

  let (:tree) { MinBinaryHeap.new(root) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }
  let (:kane) { Node.new("Citizen Kane", 99) }

  describe "#insert(data)" do
    it "properly inserts a new node as a left child" do
      tree.insert(root, shawshank)
      expect(root.left.title).to eq "The Shawshank Redemption"
    end

    it "properly inserts a new node as a left-left child" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      expect(root.left.left.title).to eq "Star Wars: A New Hope"
    end

    it "properly inserts a new node as a left-right child" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      tree.insert(root, empire)
      expect(root.left.right.title).to eq "Star Wars: The Empire Strikes Back"
    end

    it "properly inserts a new node as a right child" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      expect(root.right.title).to eq "District 9"
    end

    it "properly inserts a new node as a right-left child" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(root.right.left.title).to eq "Mad Max 2: The Road Warrior"
    end

    it "properly inserts a new node as a right-right child" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      tree.insert(root, kane)
      expect(root.right.right.title).to eq "Citizen Kane"
    end
    it "properly replaces a higher level node" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      tree.insert(root, kane)
      tree.insert(root, martian)
      expect(root.left.left.title).to eq "The Martian"
    end
    it "properly replaces root level node" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      tree.insert(root, kane)
      tree.insert(root, braveheart)
      expect(root.title).to eq "Braveheart"
    end
  end

  describe "#find(data)" do
    it "handles nil gracefully" do
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, nil)).to eq nil
    end

    it "properly finds a left node" do
      tree.insert(root, shawshank)
      expect(tree.find(root, shawshank.title).title).to eq "The Shawshank Redemption"
    end

    it "properly finds a left-left node" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      expect(tree.find(root, hope.title).title).to eq "Star Wars: A New Hope"
    end

    it "properly finds a left-right node" do
      tree.insert(root, donnie)
      tree.insert(root, inception)
      expect(tree.find(root, inception.title).title).to eq "Inception"
    end

    it "properly finds a right node" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      expect(tree.find(root, district.title).title).to eq "District 9"
    end

    it "properly finds a right-left node" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, mad_max_2.title).title).to eq "Mad Max 2: The Road Warrior"
    end

    it "properly finds a right-right node" do
      tree.insert(root, shawshank)
      tree.insert(root, district)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      tree.insert(root, kane)
      expect(tree.find(root, kane.title).title).to eq "Citizen Kane"
    end
  end

  describe "#delete(data)" do
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
end
=end
