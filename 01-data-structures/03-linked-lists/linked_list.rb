require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    node.next = nil
    if @tail
      @tail.next = node
      @tail = node
    else
      @tail = node
      @head = @tail
    end
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if @head.next
      temp = @head
      temp_next = @head.next
      while temp_next.next != nil
        temp = temp.next
        temp_next = temp.next
      end
      @tail = temp
      temp.next = nil
    else
      @head = nil
      @tail = nil
    end
  end

  # This method prints out a representation of the list.
  def print
    temp = @head
    temp_next = @head.next
    puts temp.data
    puts temp_next.data
    while temp_next.next
      temp = temp.next
      temp_next = temp.next
      puts temp_next.data
    end
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if @head == node
      if @head.next == nil
        @tail = nil
      end
      @head = @head.next
    else
      current_node = @head
      next_node = @head.next
      while next_node != node
        current_node = next_node
        next_node = current_node.next 
      end
      current_node.next = next_node.next
      if next_node.next == nil
        @tail = current_node
      end
      next_node.next = nil
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    if @head
      old_head = @head
      @head = node
      @head.next = old_head
    else
      @head = node
      @tail = @head
    end
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    if @head
      @head = @head.next
      if !@head
        @tail = @head
      end
    end
  end
end
