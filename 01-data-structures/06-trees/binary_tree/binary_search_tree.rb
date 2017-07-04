require_relative 'node'

class BinarySearchTree
  attr_reader :root
  def initialize(root)
    @root = root
  end

  def insert(root, node)
    current_node = root
    while !current_node.nil?
      if current_node.rating >= node.rating && current_node.left.nil?
        current_node.left = node
        return
      elsif current_node.rating < node.rating && current_node.right.nil?
        current_node.right = node
        return
      elsif current_node.rating >= node.rating && !current_node.left.nil?
        current_node = current_node.left
      elsif current_node.rating < node.rating && !current_node.right.nil?
        current_node = current_node.right
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    current_node = nil
    visited = []
    stack = [root]
    while !stack.empty?
      current_node = stack.pop
      visited.push(current_node)
      if current_node.left
        stack.push(current_node.left)
      end
      if current_node.right
        stack.push(current_node.right)
      end
      if current_node.left && current_node.left.title == data
        return current_node.left
      elsif current_node.right && current_node.right.title == data
        return current_node.right
      elsif stack.length == 0
        return nil
      end
    end
  end

  def delete(root, data)
  end

  # Recursive Breadth First Search
  def printf(children=nil)
  end
end
