class MyQueue
  attr_accessor :head
  attr_accessor :tail
  attr_accessor :queue_length

  def initialize
    @queue = Array.new
    @head = @queue[0]
    @queue_length = @queue.length
  end

  def enqueue(element)
    @queue[@queue.length] = element
    @head = @queue[0]
    @tail = @queue[-1]
    @queue_length = self.length
  end

  def dequeue
    @queue.slice!(0)
    @head = @queue[0]
    @tail = @queue[-1]
    @queue_length = self.length
  end

 def length
   @queue.length
 end 

  def empty?
    @head == nil ? true : false
  end
end
