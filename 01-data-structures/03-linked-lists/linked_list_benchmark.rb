require 'benchmark'
require_relative 'linked_list'

n = 100000
test_list = LinkedList.new
test_array = [] 

Benchmark.bm do |x|
  x.report(:Linitialize) { 
    for i in 0..n
      node = Node.new(i)
      test_list.add_to_tail(node)
    end 
  }

  x.report(:Ainitialize) {
    for i in 0..n
      test_array.push(i)
    end 
  } 

  x.report(:Lfind) {
    test_list.locate_node_by_index(49999)
  }

  x.report(:Afind) {
    test_array[49999]
  }

  x.report(:Ldelete) {
    test_list.delete_node_by_index(49999)
  }

  x.report(:Adelete) {
    test_array.delete_at(49999)
  }
end
