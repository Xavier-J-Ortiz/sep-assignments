class MyStack
  attr_accessor :top
  attr_accessor :stack_length

  def initialize
    @stack = Array.new
    @top = nil
    @stack_length = @stack.length
  end

  def push(item)
    @stack[@stack.length] = item
    @top = item
    @stack_length = @stack.length

  end

  def pop
    popped_item = @stack.slice!(@stack.length - 1)
    @stack_length != 0 ? @top = @stack[@stack.length - 1] : @top = nil
    @stack_length = @stack.length
    popped_item
  end

  def empty?
    @stack_length == 0 ? true : false
  end
end
