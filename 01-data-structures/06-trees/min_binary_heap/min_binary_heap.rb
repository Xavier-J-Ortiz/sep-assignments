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

    is_data_a_left_child = @tree[parent] && index % 2 == 0

    if is_data_a_left_child
      @tree[parent].left = @tree[index]
    else
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

      deleted_node_was_a_left_child = @tree[parent] && last_index % 2 == 0 
      deleted_node_was_a_right_child = @tree[parent] && last_index % 2 != 0 

      if deleted_node_was_a_left_child
        @tree[parent].left = nil
      elsif deleted_node_was_a_right_child
        @tree[parent].right = nil
      end

      element.title = last_element.title
      element.rating = last_element.rating
    else
      return nil
    end
    filter_down(element)
    filter_up(parent, element)
  end

  def filter_down element

    left_child_is_less_than_element = element.left && element.left.rating < element.rating
    right_child_is_less_than_element = element.right && element.right.rating < element.rating

    while left_child_is_less_than_element or right_child_is_less_than_element 
      if left_child_is_less_than_element
        temp_element_title = element.title
        temp_element_rating = element.rating
        element.title = element.left.title
        element.rating = element.left.rating
        element.left.title = temp_element_title
        element.left.rating = temp_element_rating
        element = element.left
      elsif right_child_is_less_than_element
        temp_element_title = element.title
        temp_element_rating = element.rating
        element.title = element.right.title
        element.rating = element.right.rating
        element.right.title = temp_element_title
        element.right.rating = temp_element_rating
        element = element.right
      end
      left_child_is_less_than_element = element.left && element.left.rating < element.rating
      right_child_is_less_than_element = element.right && element.right.rating < element.rating
    end
  end

  def  filter_up(parent, element)
    element_index = @tree.index(element)
    parent = element_index / 2
    element_is_greater_than_child = @tree[parent] && @tree[parent].rating > element.rating
    while element_is_greater_than_child
      temp_parent_title = @tree[parent].title
      temp_parent_rating = @tree[parent].rating
      @tree[parent].title = element.title
      @tree[parent].rating = element.rating
      element.title = temp_parent_title
      element.rating = temp_parent_rating
      element = @tree[parent]
      parent = element_index / 2
      element_is_greater_than_child = @tree[parent] && @tree[parent].rating > element.rating
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
