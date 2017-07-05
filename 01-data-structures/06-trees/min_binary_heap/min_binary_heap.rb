require_relative "node"

class MinBinaryHeap
  attr_reader :root
  attr_reader :tree

  def initialize(root)
    @root = root
    @tree = [nil, @root]
  end

  def insert(root, data)
    @tree.push(data)
    index = @tree.length - 1
    parent = index / 2
    
    if @tree[parent] && index % 2 == 0 
      @tree[parent].left = @tree[index]
    elsif @tree[parent] && index % 2 != 0 
      @tree[parent].right = @tree[index]
    end

    while @tree[parent] && @tree[parent].rating > @tree[index].rating
      temp = @tree[parent]
      @tree[parent].title = @tree[index].title
      @tree[parent].rating = @tree[index].rating
      @tree[index].title = temp.title
      @tree[index].rating = temp.rating
      index = parent
      parent = index / 2
    end
  end

  def find(root, data)
    (1...@tree.length).each do |location|
      if data.title == @tree[location].title
        return @tree[location]
      end    
    end
    nil
  end

  def delete(root, data)
  end
end

