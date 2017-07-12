require 'benchmark'
require_relative 'min_binary_heap/min_binary_heap'
require_relative 'binary_tree/binary_search_tree'
require_relative 'binary_tree/node'

n = 1000000
test_tree = BinarySearchTree.new(nil)
test_heap = MinBinaryHeap.new(nil)

Benchmark.bm do |x|
  x.report(:Tree_initialize) { 
    for i in 0..n
      node = Node.new(i.to_s, i)
      if i == 0
        test_tree = BinarySearchTree.new(node)
      else
        test_tree.insert(Node.new(1.to_s, 1), node)
      end
    end 
  }

  x.report(:Heap_initialize) {
    for i in 0..n
      node = Node.new(i.to_s, i)
      if i == 0
        test_heap = MinBinaryHeap.new(node)
      else
        test_heap.insert(Node.new(1.to_s, 1), node)
      end
    end 
  } 

  x.report(:Tree_find) {
    test_tree.find(Node.new(1.to_s, 1), Node.new(499999.to_s, 499999))
  }

  x.report(:Heap_find) {
    test_heap.find(Node.new(1.to_s, 1), Node.new(499999.to_s, 499999))
  }

  x.report(:Tree_delete) {
    for i in 0..5000
      j = 5000 - i
      test_tree.delete(Node.new(1.to_s, 1), Node.new(j.to_s, j))
    end
  }

  x.report(:Heap_delete) {
    for i in 0..5000
      j = 5000 - i
      test_heap.delete(Node.new(1.to_s, 1), Node.new(j.to_s, j))
    end
  }
end
