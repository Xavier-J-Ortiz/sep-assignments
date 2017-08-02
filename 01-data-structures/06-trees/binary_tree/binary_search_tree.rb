require_relative 'node'

class BinarySearchTree
  attr_reader :root
  def initialize(root)
    @root = root
  end

  def insert(root, node)
    current_node = root
    while current_node
      if current_node.rating >= node.rating
        current_node.left, current_node = insert_in_nil(current_node.left, node, current_node)
      else
        current_node.right, current_node = insert_in_nil(current_node.right, node, current_node)
      end
    end
  end

  def insert_in_nil(child_node, node, current_node)
    if child_node.nil?
      child_node = node
      current_node = nil
      return [child_node, current_node]
    else
      current_node = child_node 
      return [child_node, current_node]
    end
  end


  def find(root, data)
    current_node = nil
    queue = [root]
    while !queue.empty?
      current_node = queue.shift
      if current_node.left
        queue.push(current_node.left)
      end
      if current_node.right
        queue.push(current_node.right)
      end
      if current_node.title == data
        return current_node
      elsif queue.length == 0
        return nil
      end
    end
  end

  def delete(root, data)
    current_node = nil
    queue = [root]
    while !queue.empty?
      current_node = queue.shift
      temp_node = nil
      if current_node.left 
        queue.push(current_node.left)
        if current_node.left.title == data
          temp_node = current_node.left
          current_node.left = nil
        end
      end
      if current_node.right 
        queue.push(current_node.right)
        if current_node.right.title == data
          temp_node = current_node.right
          current_node.right = nil
        end
      end

      if temp_node
        temp_left = temp_node.left
        temp_right = temp_node.right
        if temp_right
          insert(current_node, temp_right)
        end
        if temp_left
          insert(current_node, temp_left)
        end
        return
      elsif queue.length == 0
        return nil
      end
    end
  end

  def printf(children=nil)
    current_node = nil
    queue = [root]
    while !queue.empty?
      current_node = queue.shift
      puts current_node.title + ": " + current_node.rating.to_s
      if current_node.left
        queue.push(current_node.left)
      end
      if current_node.right
        queue.push(current_node.right)
      end
    end
  end
end
