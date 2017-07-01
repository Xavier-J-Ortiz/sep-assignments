require_relative 'node'
require 'murmurhash3'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
    @keys = Array.new(size)
  end

  def []=(key, value)
    open_index = find_next_open_index(index(key, self.get_size))
    if open_index.nil? or (value != self[key] && @keys[open_index] == key)
      self.resize
      self[key] = value
      return
    end
    @items[open_index] = value
    @keys[open_index] = key
  end

  def [](key)
    original_true_index = index(key, self.get_size)
    true_index = original_true_index
    while @keys[true_index] != key and (true_index != ((original_true_index - 1) % self.get_size))
      true_index = (true_index + 1) % self.get_size
    end
    if @keys[true_index] == key
      return @items[true_index]
    end
  end

  def index(key, size)
    MurmurHash3::V32.str_hash(key.to_s, size) % size
  end

  # Given an index, find the next open index in @items
  def find_next_open_index(index)
    original_true_index = index
    true_index = original_true_index
    while !@items[true_index].nil? and !@keys[true_index].nil? do
      true_index = (true_index + 1) % self.get_size
      if original_true_index == true_index
        return nil
      end
    end
    true_index
  end

  # Simple method to return the number of items in the hash
  def get_size
    @items.length
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
