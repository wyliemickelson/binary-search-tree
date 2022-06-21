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
    rebalance unless balanced?
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
      rebalance unless balanced?
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

  def level_order(values = [], &block)
    curr_node = root
    queue = [curr_node] unless curr_node.nil?
    until queue.empty?
      curr_node = queue.pop
      block_given?  ? block.call(curr_node) : values << curr_node.data
      queue.unshift(curr_node.left) unless curr_node.left.nil?
      queue.unshift(curr_node.right) unless curr_node.right.nil?
    end
    values
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

  def height(curr_root = root)
    return 0 if curr_root.nil?
    left_height = curr_root.left.nil? ? 0 : 1 + height(curr_root.left)
    right_height = curr_root.right.nil? ? 0 : 1 + height(curr_root.right)
    left_height > right_height ? left_height : right_height
  end

  def depth(node, curr_root = root)
    return 0 if curr_root == node
    node < curr_root ? depth(node, curr_root.left) + 1 : depth(node, curr_root.right) + 1
  end

  def balanced?(curr_root = root)
    return true if curr_root.nil?
    balanced?(curr_root.left) && balanced?(curr_root.right) && (height(curr_root.left) - height(curr_root.right)).abs <= 1
  end

  def rebalance
    self.root = build_tree(inorder)
  end

  def pretty_print(node = @root, prefix = "", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
  end
end

tree = Tree.new(Array.new(rand(5..20)) { rand(1..100) })
tree.pretty_print
p tree.balanced?
p tree.level_order
p tree.preorder
p tree.inorder
p tree.postorder
20.times { tree.insert(rand(101..150)) }
tree.pretty_print