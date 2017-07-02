require_relative 'linked_list'
require 'murmurhash3'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @buckets = Array.new(size)
    @items = 0
  end

  def []=(key, value)
    true_index = index(key, self.get_size)
    #node = Node.new(key, value)
    if !@buckets[true_index].nil?
      node = @buckets[true_index].head
      while !node.nil?
        if node.key == key
          node.value = value
          return
        end
        node = node.next
      end
      @buckets[true_index].add_to_tail(Node.new(key, value))
    elsif @buckets[true_index].nil?
      @buckets[true_index] = LinkedList.new
      @buckets[true_index].add_to_tail(Node.new(key, value))
    end
    @items += 1.0
    if @max_load_factor <= self.load_factor
      self.resize
    end
  end

  def [](key)
    true_index = index(key, self.get_size)
    if !@buckets[true_index].nil?
      identified_list = @buckets[true_index]
      node = identified_list.head
      while !node.nil? or node.key != key
        if node.key == key
          return node.value
        end
        node = node.next
      end 
      return nil
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    MurmurHash3::V32.str_hash(key.to_s, size) % size
  end

  # Calculate the current load factor
  def load_factor
    @items / self.get_size
  end

  # Simple method to return the number of items in the hash
  def get_size
    @buckets.length
  end

  # Resize the hash
  def resize
    old_buckets = @buckets.clone
    @buckets = Array.new(self.get_size * 2)
    @items = 0
    (0...old_buckets.length).each do |old_index|
      if (old_buckets[old_index])
        node = old_buckets[old_index].head
        while !node.nil? 
          self[node.key] = node.value
          node = node.next
        end
      end
    end
  end
  def print_status
    puts
    puts "the array size is: " + self.get_size.to_s
    puts "the load factor is: " + self.load_factor.to_s
    puts "the array state is :"
    puts "{"
    counter = 0
    for element in @buckets do
      print "\t" + counter.to_s + " : "
      if !element.nil?
        print "{"
        element.print_status
        puts "}"
      else
        puts "{nil}"
      end
      counter += 1
    end
    puts "}"
  end
end
