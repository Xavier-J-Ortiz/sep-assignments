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

    while tree[parent] && is_parent_greater_than_child(index, parent)
      swap_node_position(@tree[parent], @tree[index])
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
    @tree[parent].rating > @tree[index].rating
  end

  def delete(root, data)
    element = find(root, data)
    if element
      last_index = @tree.length - 1
      parent = last_index / 2
      last_element = @tree.pop

      popped_node_was_a_left_child = @tree[parent] && last_index % 2 == 0 
      popped_node_was_a_right_child = @tree[parent] && last_index % 2 != 0 

      if popped_node_was_a_left_child
        @tree[parent].left = nil
      elsif popped_node_was_a_right_child
        @tree[parent].right = nil
      end

      element.title = last_element.title
      element.rating = last_element.rating
    else
      return nil
    end

    filter_down(element)
    filter_up(element)
  end

  def filter_down element

    left_child_is_less_than_element = element.left && element.left.rating < element.rating
    right_child_is_less_than_element = element.right && element.right.rating < element.rating

    while left_child_is_less_than_element or right_child_is_less_than_element 
      lower_rated_element = nil
      if left_child_is_less_than_element
        lower_rated_element = element.left
      elsif right_child_is_less_than_element
        lower_rated_element = element.right
      end
      element = swap_node_position(element, lower_rated_element)
      left_child_is_less_than_element = element.left && element.left.rating < element.rating
      right_child_is_less_than_element = element.right && element.right.rating < element.rating
    end
  end

  def filter_up(element)
    element_index = @tree.index(element)
    parent = element_index / 2
    element_is_greater_than_child = @tree[parent] && @tree[parent].rating > element.rating
    while element_is_greater_than_child
      swap_node_position(@tree[parent], element)
      parent = element_index / 2
      element_is_greater_than_child = @tree[parent] && @tree[parent].rating > element.rating
    end
  end

  def swap_node_position(higher_node, lower_node)
    temp_element_title = higher_node.title
    temp_element_rating = higher_node.rating
    higher_node.title = lower_node.title
    higher_node.rating = lower_node.rating
    lower_node.title = temp_element_title
    lower_node.rating = temp_element_rating
    lower_node
  end

  def printf
    @tree.each do |node|
      if node
        puts node.title + ": " + node.rating.to_s
      end
    end
  end
end
