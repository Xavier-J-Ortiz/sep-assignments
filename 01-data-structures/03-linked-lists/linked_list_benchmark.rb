require 'benchmark'
require_relative 'linked_list'

n = 10000
test_list = LinkedList.new
test_array = [] 

Benchmark.bm do |x|
  x.report(:L) { 
    for i in 0..n
      node = Node.new(i)
      test_list.add_to_tail(node)
    end 
  }

  x.report(:A) {
    for i in 0..n
      test_array.push(i)
    end 
  } 

  x.report(:Lfind) {
    test_list.locate_node_by_index(4999)
  }

  x.report(:Afind) {
    test_array[4999]
  }

  x.report(:Ldelete) {
    test_list.delete_node_by_index(4999)
  }

  x.report(:Adelete) {
    test_array.delete(4999)
  }


end
