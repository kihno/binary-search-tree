require_relative 'node'

class Tree
  attr_accessor :root

  def initialize(array = [])
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array, start = 0, tail = array.length - 1)
    middle = (start + tail) / 2
    root = Node.new(array[middle])

    return nil if start > tail

    root.left = build_tree(array, start, middle - 1)
    root.right = build_tree(array, middle + 1, tail)

    root
  end

  def insert(value)
    current = @root
    prev = nil
    node = Node.new(value)

    until current.nil?
      prev = current

      if current.data > value
        current = current.left
      else
        current = current.right
      end
    end

    if prev.data > value
      prev.left = node
    else
      prev.right = node
    end
  end

  def delete(value, current = @root)
    return current if current.nil?

    if current.data > value
      current.left = delete(value, current.left)
    elsif current.data < value
      current.right = delete(value, current.right)
    else
      return current.right if current.left.nil?
      return current.left if current.right.nil?

      current.data = min_value(current.right)
      current.right = delete(current.data, current.right)
    end

    current
  end

  def min_value(root)
    value = root.data

    until root.left.nil?
      value = root.left.data
      root = root.left
    end

    value
  end

  def find(value)
    root = @root

    until root.data == value
      if root.data > value
        root = root.left
      else
        root = root.right
      end
    end

    root
  end

  def level_order
    node = @root
    queue = []
    output = []

    return if node.nil?

    queue.push(node)

    until queue.empty?
      current = queue[0]
      output.push(current.data)
      queue.push(current.left) unless current.left.nil?
      queue.push(current.right) unless current.right.nil?
      queue.shift
    end

    block_given? ? output.each { |el| yield el } : output
  end

  def inorder(node = @root, output = [])
    return if node.nil?

    inorder(node.left, output)
    output.push(node.data)
    inorder(node.right, output)

    block_given? ? output.each { |el| yield el } : output
  end

  def preorder(node = @root, output = [])
    return if node.nil?

    output.push(node.data)
    preorder(node.left, output)
    preorder(node.right, output)

    block_given? ? output.each { |el| yield el } : output
  end

  def postorder(node = @root, output = [])
    return if node.nil?

    postorder(node.left, output)
    postorder(node.right, output)
    output.push(node.data)

    block_given? ? output.each { |el| yield el } : output
  end

  def height(node = @root)
    return 0 if node.nil?

    left = node.left ? height(node.left) : 0
    right = node.right ? height(node.right) : 0
    left > right ? left + 1 : right + 1
  end

  def depth(node = @root)
    height(@root) - height(node)
  end

  def balanced?(node = @root)
    return true if node.nil?

    return true if balanced?(node.left) && balanced?(node.right) && (height(node.left) - height(node.right)).abs <= 1

    false
  end

  def rebalance
    @array = inorder
    @root = build_tree(@array)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
