require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
  end

  # O(1)
  def [](index)
    check_index(index)
    store[index]
  end

  # O(1)
  def []=(index, value)
    check_index(index)
    store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" unless length > 0
    popped = self[length - 1]
    self[length - 1] = nil
    self.length -= 1

    popped
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if length == capacity
    self.length += 1
    self[length - 1] = val

    nil
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if length == 0
    value = self[0]
    (1...length).each { |i| self[i - 1] = self[i] }
    self.length -= 1

    value
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if length == capacity

    self.length += 1
    (length - 2).downto(0).each { |i| self[i + 1] = self[i] }
    self[0] = val

    nil
  end

  protected
  
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
    if (index < 0) || (index >= length)
      raise "index out of bounds"
    end
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_cap = capacity * 2
    new_store = StaticArray.new(new_cap)
    (0...length).each do |i|
      new_store[i] = self[i]
    end
    self.capacity = new_cap
    self.store = new_store
  end
end
