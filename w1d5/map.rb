class Map

  def initialize
    @map = []
  end

  def assign(key, value)
    main_idx = @map.index { |arr| arr[0] == key }
    if main_idx
      @map[main_idx][1] = value
    else
      @map.push([key, value])
      [key, value]
  end

  def lookup(key)
    @map.each { |pair| return pair[1] if pair[0] == key }
    nil
  end

  def remove(key)
    @map.reject! { |pair| pair[0] == key }
    nil
  end

  def show
    deep_dup(@map)
  end

  private

  def deep_dup(arr)
    return [arr] if arr.length == 1
    new_arr = []

    arr.each do |el|
      if el.is_a?(Array)
        new_arr << deep_dup(el)
      else
        new_arr << el.dup
      end
    end
    new_arr
  end

end
