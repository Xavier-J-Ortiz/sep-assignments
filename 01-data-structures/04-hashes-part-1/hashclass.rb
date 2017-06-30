class HashClass
  require 'murmurhash3'
  def initialize(size)
    @items = Array.new(size)
    @keys = Array.new(size)
  end

  def []=(key, value)
    true_index = index(key, self.size)
    if @items[true_index].nil? 
      @keys[true_index] = key
      @items[true_index] = value
    elsif (value != self[key] && !(@keys[true_index] == key))
      while !@items[true_index].nil? 
        self.resize
        true_index = index(key, self.size)
      end
      @keys[true_index] = key
      @items[true_index] = value
    elsif (value != self[key] && (@keys[true_index] == key))
      self.resize
      true_index = index(key, self.size)
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

  def index(key, size)
    MurmurHash3::V32.str_hash(key.to_s, size) % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end
end
