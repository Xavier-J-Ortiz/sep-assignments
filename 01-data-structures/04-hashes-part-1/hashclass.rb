class HashClass
  require 'murmurhash3'

  def initialize(size)
    @items = Array.new(size)
    @keys = Array.new(size)
  end

  def []=(key, value)
    true_index = index(key, self.get_size)
    item_is_empty = @items[true_index].nil?
    value_is_different = (value != self[key] && @keys[true_index] == key)
    key_is_different = @keys[true_index] != key
    if item_is_empty 
      @keys[true_index] = key
      @items[true_index] = value
      self.print_status
    elsif value_is_different
      self.resize
      true_index = index(key, self.get_size)
      @keys[true_index] = key
      @items[true_index] = value
    elsif key_is_different
      self.resize
      self[key] = value
    end
  end

  def [](key)
    true_index = index(key, self.get_size)
    @items[true_index]
  end

  def resize
    old_items = @items
    old_keys = @keys
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
    puts "\nthe array size is: " + self.get_size.to_s
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
