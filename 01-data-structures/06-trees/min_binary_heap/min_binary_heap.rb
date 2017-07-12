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

    while is_parent_greater_than_child(index, parent)
      temp_title = @tree[parent].title
      temp_rating = @tree[parent].rating
      @tree[parent].title = @tree[index].title
      @tree[parent].rating = @tree[index].rating
      @tree[index].title = temp_title
      @tree[index].rating = temp_rating
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

  def  is_parent_greater_than_child(index, parent)
    @tree[parent] && @tree[parent].rating > @tree[index].rating
  end

  def delete(root, data)
    element = find(root, data)
    if element
      last_index = @tree.length - 1
      parent = last_index / 2
      last_element = @tree.pop

      deleted_was_left = @tree[parent] && last_index % 2 == 0 
      deleted_was_right = @tree[parent] && last_index % 2 != 0 

      if deleted_was_left
        @tree[parent].left = nil
      elsif deleted_was_right
        @tree[parent].right = nil
      end

      element.title = last_element.title
      element.rating = last_element.rating
    else
      return nil
    end

    left_child_is_less_than_parent = element.left && element.left.rating < element.rating
    right_child_is_less_than_parent = element.right && element.right.rating < element.rating

    while left_child_is_less_than_parent or right_child_is_less_than_parent 
      if left_child_is_less_than_parent && right_child_is_less_than_parent
        if element.left.rating <= element.right.rating
          temp_element_title = element.title
          temp_element_rating = element.rating
          element.title = element.left.title
          element.rating = element.left.rating
          element.left.title = temp_element_title
          element.left.rating = temp_element_rating
          element = element.left
        elsif element.right.rating < element.left.rating
          temp_element_title = element.title
          temp_element_rating = element.rating
          element.title = element.right.title
          element.rating = element.right.rating
          element.right.title = temp_element_title
          element.right.rating = temp_element_rating
          element = element.right
        end
      else
        if left_child_is_less_than_parent
          temp_element_title = element.title
          temp_element_rating = element.rating
          element.title = element.left.title
          element.rating = element.left.rating
          element.left.title = temp_element_title
          element.left.rating = temp_element_rating
          element = element.left
        end
        if right_child_is_less_than_parent
          temp_element_title = element.title
          temp_element_rating = element.rating
          element.title = element.right.title
          element.rating = element.right.rating
          element.right.title = temp_element_title
          element.right.rating = temp_element_rating
          element = element.right
        end
      end
      left_child_is_less_than_parent = element.left && element.left.rating < element.rating
      right_child_is_less_than_parent = element.right && element.right.rating < element.rating
    end

    element_index = @tree.index(element)
    parent = element_index / 2

    parent_is_greater_than_child = @tree[parent] && @tree[parent].rating > element.rating

    while parent_is_greater_than_child
      temp_parent_title = @tree[parent].title
      temp_parent_rating = @tree[parent].rating
      @tree[parent].title = element.title
      @tree[parent].rating = element.rating
      element.title = temp_parent_title
      element.rating = temp_parent_rating

      element = @tree[parent]
      parent = element_index / 2

      parent_is_greater_than_child = @tree[parent] && @tree[parent].rating > element.rating

    end
  end

  def printf
    @tree.each do |node|
      if node
        puts node.title + ": " + node.rating.to_s
      end
    end
  end
end
