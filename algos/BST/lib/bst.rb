class BSTNode
  attr_accessor :left, :right
  attr_reader :value

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end

class BinarySearchTree
  def initialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = BSTNode.new(value)
    else
      BinarySearchTree.insert!(@root, value)
    end
  end

  def find(value)
    BinarySearchTree.find!(@root, value)
  end

  def inorder
    BinarySearchTree.inorder!(@root)
  end

  def postorder
    BinarySearchTree.postorder!(@root)
  end

  def preorder
    BinarySearchTree.preorder!(@root)
  end

  def height
    BinarySearchTree.height!(@root)
  end

  def min
    BinarySearchTree.min(@root)
  end

  def max
    BinarySearchTree.max(@root)
  end

  def delete(value)
    @root = BinarySearchTree.delete!(@root, value)
  end

  def self.insert!(node, value)
    if node
      if value > node.value
        node.right = BinarySearchTree.insert!(node.right, value)
      else
        node.left = BinarySearchTree.insert!(node.left, value)
      end
      node
    else
      BSTNode.new(value)
    end
  end

  def self.find!(node, value)
    return nil unless node
    if node.value == value
      return node
    end

    if value >= node.value
      BinarySearchTree.find!(node.right, value)
    else
      BinarySearchTree.find!(node.left, value)
    end
  end

  def self.preorder!(node)
    return [] unless node

    a = []
    a << node.value
    if node.left
      a += BinarySearchTree.preorder!(node.left)
    end
    if node.right
      a += BinarySearchTree.preorder!(node.right)
    end

    a
  end

  def self.inorder!(node)
    return [] unless node
    a = []
    if node.left
      a+= BinarySearchTree.inorder!(node.left)
    end
    a << node.value
    if node.right
      a += BinarySearchTree.inorder!(node.right)
    end

    a
  end

  def self.postorder!(node)
    return [] unless node

    a = []
    if node.left
      a += BinarySearchTree.postorder!(node.left)
    end

    if node.right
      a += BinarySearchTree.postorder!(node.right)
    end
    a << node.value

    a
  end

  def self.height!(node)
    return -1 unless node

    left = BinarySearchTree.height!(node.left)
    right = BinarySearchTree.height!(node.right)

    1 + [left, right].max
  end

  def self.max(node)
    return nil unless node
    return node unless node.right

    BinarySearchTree.max(node.right)
  end

  def self.min(node)
    return nil unless node
    return node unless node.left

    BinarySearchTree.min(node.left)
  end

  def self.delete_min!(node)
    return nil unless node
    return node.right unless node.left

    node.left = BinarySearchTree.delete_min!(node.left)
  end

  def self.delete!(node, value)
    return nil unless node

    if value > node.value
      node.right = BinarySearchTree.delete!(node.right, value)
    elsif value < node.value
      node.left = BinarySearchTree.delete!(node.left, value)
    else
      return node.left unless node.right
      return node.right unless node.left
      node1 = node

      node = node1.right.min
      node.right = BinarySearchTree.delete_min!(node1.right)
      node.left = node1.left
    end
    node
  end
end
