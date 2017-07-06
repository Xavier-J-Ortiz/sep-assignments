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
      if @tree[parent] != root
      temp = @tree[parent]
      else
        temp = @tree[parent].clone
      end
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
    element = find(root, data)
    if element
      last_index = @tree.length - 1
      parent = last_index / 2
      last_element = @tree.pop
      if @tree[parent] && last_index % 2 == 0 
        @tree[parent].left = nil
      elsif @tree[parent] && last_index % 2 != 0 
        @tree[parent].right = nil
      end

      element.title = last_element.title
      element.rating = last_element.rating
    else
      return nil
    end
    while (element.left && element.left.rating < element.rating) or (element.right && element.right.rating < element.rating)
      if element.left && element.right && 
          (element.left.rating < element.rating && element.right.rating < element.rating)
        if element.left.rating <= element.right.rating
          temp_element = element
          element.title = element.left.title
          element.rating = element.left.rating
          element.left.title = temp_element.title
          element.left.rating = temp_element.rating
          element = element.left
        elsif element.right.rating < element.left.rating
          temp_element = element
          element.title = element.right.title
          element.rating = element.right.rating
          element.right.title = temp_element.title
          element.right.rating = temp_element.rating
          element = element.right
        end
      else
        if element.left && (element.left.rating < element.rating)
          temp_element = element
          element.title = element.left.title
          element.rating = element.left.rating
          element.left.title = temp_element.title
          element.left.rating = temp_element.rating
          element = element.left
        end
        if element.right && (element.right.rating < element.rating)
          temp_element = element
          element.title = element.right.title
          element.rating = element.right.rating
          element.right.title = temp_element.title
          element.right.rating = temp_element.rating
          element = element.right
        end
      end
    end

    element_index = @tree.index(element)
    parent = element_index / 2

    # need to add an upfilter
    while (@tree[parent] && @tree[parent].rating > element.rating) 
      temp_parent = @tree[parent]
      tree[parent].title = element.title
      tree[parent].rating = element.rating
      element.title = temp_parent.title
      element.rating = temp_parent.rating

      element = tree[parent]
      parent = element_index / 2
    end
  end

  def printf
    tree.each do |node|
      if node
        puts node.title + ": " + node.rating.to_s
      end
    end
  end
end
