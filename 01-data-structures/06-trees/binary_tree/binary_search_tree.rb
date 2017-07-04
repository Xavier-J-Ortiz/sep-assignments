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
    stack = [root]
    while !stack.empty?
      current_node = stack.pop
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
    current_node = nil
    stack = [root]
    while !stack.empty?
      current_node = stack.pop
      if current_node.left
        stack.push(current_node.left)
      end
      if current_node.right
        stack.push(current_node.right)
      end
      if current_node.left && current_node.left.title == data
        temp_left = current_node.left.left
        temp_right = current_node.left.right
        current_node.left = nil
        if temp_right
          insert(current_node, temp_right)
        end
        if temp_left
          insert(current_node, temp_left)
        end
        return
      elsif current_node.right && current_node.right.title == data
        temp_left = current_node.right.left
        temp_right = current_node.right.right
        current_node.right = nil
        if temp_right
          insert(current_node, temp_right)
        end
        if temp_left
          insert(current_node, temp_left)
        end
        return
      elsif stack.length == 0
        return nil
      end
    end
  end

  # Recursive Breadth First Search
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
