require_relative 'node'
class MinBinaryHeap
  attr_reader :root

  def initialize(root)
    @root = root
  end
  #
  #left
  #right
  #parent
  #title
  #rating
  #
  def insert(root, node)
    current_node = nil
    queue = [root]
    # puts "root " + root.title
    while !queue.empty? and current_node != node
      current_node = queue.shift
      if current_node.left
        # puts "left " + current_node.left.title
        queue.push(current_node.left)
      end
      if current_node.right
        # puts "right " + current_node.right.title
        queue.push(current_node.right)
      end
      if current_node.left.nil?
        current_node.left = node
        node.parent = current_node
        current_node = node
      elsif current_node.right.nil?
        current_node.right = node
        node.parent = current_node
        current_node = node
      end
    end
    while current_node.parent && current_node.rating < current_node.parent.rating
      old_parent = current_node.parent.clone
      current_node.parent.title = current_node.title
      current_node.parent.rating = current_node.rating
      current_node.title = old_parent.title
      current_node.rating = old_parent.rating
      current_node = current_node.parent
    end
  end
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
end
