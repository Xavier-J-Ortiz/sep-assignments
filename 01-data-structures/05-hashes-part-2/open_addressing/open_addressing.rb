require_relative 'node'
require 'murmurhash3'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
    @keys = Array.new(size)
    @number_of_items = 0.0
  end

  def []=(key, value)
    true_index = index(key, self.get_size)
    open_index = find_next_open_index(true_index)
    if !open_index.nil? && self[key].nil? 
      @items[open_index] = value
      @keys[open_index] = key
      @number_of_items += 1.0
    elsif !self[key].nil?
      @items[true_index] = value
    else 
      self.resize
      self[key] = value
      return
    end
  end

  def [](key)
    true_index = index(key, self.get_size)
    search_index = true_index
    while verify_single_loop(search_index, true_index, key)
      search_index = (search_index + 1) % self.get_size
    end
    if @keys[search_index] == key
      return @items[search_index]
    else
      return nil
    end
  end

  def verify_single_loop(search_index, true_index, key)
    @keys[search_index] != key and 
      (search_index != ((true_index - 1) % self.get_size))
  end

  def index(key, size)
    MurmurHash3::V32.str_hash(key.to_s, size) % size
  end

  def find_next_open_index(index)
    true_index = index
    open_index = true_index
    while !@items[open_index].nil? and !@keys[open_index].nil? do
      open_index = (open_index + 1) % self.get_size
      if true_index == open_index
        return nil
      end
    end
    open_index
  end

  def get_size
    @items.length
  end

  def resize
    old_items = @items
    old_keys = @keys
    @items = Array.new(self.get_size * 2)
    @keys = Array.new(self.get_size)
    @number_of_items = 0
    (0...old_keys.length).each do |old_index|
      if (old_keys[old_index] && old_items[old_index])
        self[old_keys[old_index]] = old_items[old_index]
      end
    end
  end

  def print_status
    puts
    puts "the array size is: " + self.get_size.to_s
    puts "the load factor is: " + (@number_of_items / self.get_size).to_s
    puts "the array state is :"
    puts "{ "
    counter = 0
    for element in @keys do
      print "\t" + counter.to_s + " : "
      if !element.nil?
        puts "{" + element.to_s + " : " + self[element].to_s + "},"
      else
        puts "{nil}, "
      end
      counter += 1
    end
    puts "}"
  end
end
