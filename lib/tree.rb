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
    if value < curr_root.data
      curr_root.left = rec_insert(curr_root.left, value)
    else
      curr_root.right = rec_insert(curr_root.right, value)
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

  def find(value)
  end

  def level_order(&block)
  end

  def preorder(&block)
  end

  def inorder(&block)
  end

  def postorder(&block)
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
tree.rec_insert(2)
tree.rec_insert(34)
tree.rec_insert(35)
puts "------------------------"
tree.pretty_print
puts "------------------------"
puts tree.min_value

