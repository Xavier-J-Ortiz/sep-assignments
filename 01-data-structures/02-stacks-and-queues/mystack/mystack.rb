class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
  end

  def push(item)
    if empty?
      @stack[0] = item
      self.top = item
    else
      @stack[@stack.length] = item
      self.top = item
    end
  end

  def pop
    if !empty? 
      popped_item = @stack.slice!(@stack.length - 1)
      @stack.length != 0 ? self.top = @stack[@stack.length - 1] : self.top = nil
      return popped_item
    end
    self.top
  end

  def empty?
    if self.top != nil
      return false 
    end
    true
  end
end
