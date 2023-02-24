require_relative 'tree'

my_array = Array.new(14) { rand(1..100) }

my_tree = Tree.new(my_array)

my_tree.pretty_print

p my_tree.balanced?
p my_tree.level_order
p my_tree.preorder
p my_tree.inorder
p my_tree.postorder

my_tree.insert(rand(1..100))
my_tree.insert(rand(1..100))
my_tree.insert(rand(1..100))
my_tree.insert(rand(1..100))
my_tree.insert(rand(1..100))
my_tree.insert(rand(1..100))
my_tree.insert(rand(1..100))

my_tree.pretty_print
p my_tree.balanced?

my_tree.rebalance
my_tree.pretty_print
p my_tree.balanced?
