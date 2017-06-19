require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail
  attr_accessor :length

  def add_to_tail(node)
    node.next = nil
    if @tail
      @tail.next = node
      @tail = node
      @length += 1
    else
      @tail = node
      @head = @tail
      @length = 1
    end
  end

  def remove_tail
    if @head.next
      @tail = find_node_prior(@tail, false)
      @tail.next = nil
      @length -= 1
    else
      @head = nil
      @tail = nil
      @length = 0
    end
  end


  def print
    find_node_prior(@tail, true) 
  end

  def delete(node)
    if @head != node
      current_node = find_node_prior(node, false)      
      delete_next_node(current_node)
    else
      self.remove_front
    end
  end

  def add_to_front(node)
    if @head
      node.next = @head
      @head = node
      @length += 1
    else
      @head = node
      @tail = @head
      @length = 1
    end
  end

  def remove_front
    if @head
      @head = @head.next
      if !@head
        @tail = @head
      end
      @length -= 1
    end
  end

  def delete_node_by_index(index)
    if index == 0
      self.remove_front
    else
      delete_next_node(locate_node_by_index(index - 1))
    end
  end

  def  locate_node_by_index(index)
    if index < @length and index >= 0
      current_node = @head
      next_node = @head.next
      for i in (1..index)
        current_node = next_node
        next_node = current_node.next 
      end
      return current_node
    else
      return nil
    end

  end

  def find_node_prior(said_node, print)
    node = @head
    if print
      puts node.data
      puts node.next.data
    end
    while node.next.next != said_node.next
      node = node.next
      if print
        puts node.next.data
      end
    end
    node 
  end

  def delete_next_node(current_node)
    if current_node.next.next == nil
      @tail = current_node
    end
    current_node.next = current_node.next.next
    @length -= 1
  end
end
