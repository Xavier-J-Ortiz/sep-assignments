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
    if (@tail && @head && @head.next)
      @tail = find_previous_node(@tail)
      @tail.next = nil
      @length -= 1
    else
      @head = nil
      @tail = nil
      @length = 0
    end
  end

  def print
    puts @head.data
    node = @head
    while node.next != nil
      node = node.next
      puts node.data
    end
  end

  def delete(node)
    if @head != node
      current_node = find_previous_node(node)      
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
    if index != 0
      previous_node = locate_node_by_index(index - 1)
      delete_next_node(previous_node)
    else
      self.remove_front
    end
  end

  def locate_node_by_index(index)
    if index < @length and index >= 0
      current_node = @head
      for i in (1..index)
        current_node = current_node.next
      end
      return current_node
    else
      return nil
    end
  end

  def find_previous_node(current_node)
    node = @head
    while (node.next != current_node && node != @tail)
      node = node.next
    end
    if node.next != nil
      return node
    else 
      return nil
    end
  end

  def delete_next_node(current_node)
    if (current_node != @tail && current_node != nil)
      if current_node.next.next == nil
        @tail = current_node
      end
      current_node.next = current_node.next.next
      @length -= 1
    else
      return nil
    end
  end
end
