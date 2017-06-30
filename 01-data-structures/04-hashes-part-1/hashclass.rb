class HashClass
  require 'murmurhash3'

  def initialize(size)
    @items = Array.new(size)
    @keys = Array.new(size)
  end

  def []=(key, value)
    true_index = index(key, self.get_size)
    if @items[true_index].nil? or (value != self[key] && @keys[true_index] == key)
      if (value != self[key] && @keys[true_index] == key)
        self.resize
        true_index = index(key, self.get_size)
      end
      @keys[true_index] = key
      @items[true_index] = value
      self.print_status
    elsif (value != self[key] && !(@keys[true_index] == key))
      while !@items[true_index].nil? 
        self.resize
        true_index = index(key, self.get_size)
      end
      self[key] = value
    end
  end

  def [](key)
    true_index = index(key, self.get_size)
    @items[true_index]
  end

  def resize
    old_items = @items.clone
    old_keys = @keys.clone
    @items = Array.new(self.get_size * 2)
    @keys = Array.new(self.get_size)
    (0...old_keys.length).each do |old_index|
      if (old_keys[old_index] && old_items[old_index])
        self[old_keys[old_index]] = old_items[old_index]
      end
    end
  end

  def index(key, size)
    MurmurHash3::V32.str_hash(key.to_s, size) % size
  end

  def get_size
    @items.length
  end

  def print_status
    puts
    puts "the array size is: " + self.get_size.to_s
    puts "the array state is :"
    puts "{"
    for element in @keys do
      if !element.nil?
        puts "\t'" + element.to_s + "' : '" + self[element].to_s + "',"
      end
    end
    puts "}"
  end
end
