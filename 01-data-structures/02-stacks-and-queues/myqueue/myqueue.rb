class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = @queue[0]
  end

  def enqueue(element)
    @queue[@queue.length] = element

    if @queue.length == 1
      @head = @queue[0]
    end
    @tail = @queue[-1]
  end

  def dequeue
    @queue.slice!(0)
    @head = @queue[0]
    if @queue.length == 0
      @tail = @queue[-1]
    end
  end

  def empty?
    @head == nil ? true : false
  end
end
