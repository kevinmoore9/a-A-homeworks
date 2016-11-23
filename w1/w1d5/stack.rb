class Stack
  def initialize
    @tower = []
  end

  def add(el)
    @tower << el
  end

  def remove
    @tower.pop
  end

  def show
    @tower.dup
  end
end
