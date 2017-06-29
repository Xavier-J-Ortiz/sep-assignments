class HashClass
  attr_reader :items
  attr_reader :keys
    
  def initialize(size)
    @items = Array.new(size)
    @keys = Array.new(size)
  end

  def []=(key, value)
    true_index = index(key, self.size)
    if @items[true_index].nil? 
      @keys[true_index] = key
      @items[true_index] = value
    elsif value != self[key]
      while !@items[true_index].nil?
        self.resize
        true_index = index(key, self.size)
      end
      @keys[true_index] = key
      @items[true_index] = value
    end
  end

  def [](key)
    true_index = index(key, self.size)
    @items[true_index]
  end

  def resize
    old_items = @items.clone
    old_keys = @keys.clone
    @items = Array.new(self.size * 2)
    @keys = Array.new(self.size)
    (0...old_keys.length).each do |old_index|
      if (old_keys[old_index] && old_items[old_index])
        self[old_keys[old_index]] = old_items[old_index]
      end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    ascii_sum = 0
    key.each_byte do |ascii_number|
      ascii_sum += ascii_number
    end
    ascii_sum % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

end
