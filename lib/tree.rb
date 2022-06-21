require_relative "node.rb"

class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(arr)
    return if arr.empty?
    sorted = arr.uniq.sort
    middle = sorted.length / 2
    new_node = Node.new(sorted[middle])
    new_node.left = build_tree(sorted[0...middle])
    new_node.right = build_tree(sorted[(middle + 1)..-1])
    new_node
  end

  def insert(curr_root = root, value)
    return Node.new(value) if curr_root.nil?
    return curr_root if curr_root.data == value
    if value < curr_root.data
      curr_root.left = insert(curr_root.left, value)
    else
      curr_root.right = insert(curr_root.right, value)
    end
    curr_root
  end

  def delete(curr_root = root, value)
    return nil if curr_root.nil?
    if value < curr_root.data
      curr_root.left = delete(curr_root.left, value)
    elsif value > curr_root.data
      curr_root.right = delete(curr_root.right, value)
    else
      return curr_root.right if curr_root.left.nil?
      return curr_root.left if curr_root.right.nil?
      curr_root.data = min_value(curr_root.right)
      curr_root.right = delete(curr_root.right, curr_root.data)
    end
  end

  def min_value(curr_root = root)
    return curr_root.data if curr_root.left.nil?
    min_value(curr_root.left)
  end

  def find(curr_root = root, value)
    return curr_root if curr_root.data == value
    value < curr_root.data ? find(curr_root.left, value) : find(curr_root.right, value)
  end

  def level_order(&block)

  end

  def preorder(curr_root = root, values = [], &block)
    return values if curr_root.nil?
    block_given? ? block.call(curr_root) : values << curr_root.data
    preorder(curr_root.left, values, &block)
    preorder(curr_root.right, values, &block)
  end

  def inorder(curr_root = root, values = [], &block)
    return values if curr_root.nil?
    inorder(curr_root.left, values, &block)
    block_given? ? block.call(curr_root) : values << curr_root.data
    inorder(curr_root.right, values, &block)
  end

  def postorder(curr_root = root, values = [], &block)
    return values if curr_root.nil?
    postorder(curr_root.left, values, &block)
    postorder(curr_root.right, values, &block)
    block_given? ? block.call(curr_root) : values << curr_root.data
  end

  def height(node)
  end

  def depth(node)
  end

  def balanced?
  end

  def rebalance
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
  end
end

arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
tree = Tree.new(arr)
tree.pretty_print
tree.insert(2)
tree.insert(2)
tree.insert(34)
tree.insert(35)
puts "------------------------"
tree.pretty_print
puts "------------------------"
puts tree.min_value
puts "------------------------"
puts tree.find(6345).data
p tree.inorder
puts "------------------------"
p tree.preorder
puts "------------------------"
p tree.postorder
puts "------------------------"
tree.pretty_print

