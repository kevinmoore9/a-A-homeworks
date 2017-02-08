class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length === 0

    piv = array.first

    left = array.select do |el|
      el < piv
    end

    right = array.select do |el|
      el >= piv
    end

    sort1(left) + piv + sort1(right)

  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    if length <= 1
      return array
    end

    i = partition(array, start, length, &prc)
    num_left = i - start
    num_right = length - 1 - num_left

    sort2!(array, start, num_left, &prc)
    sort2!(array, i + 1, num_right, &prc)
    array

  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    i = start
    piv = array[start]

    (start + 1).upto(start + length - 1) do |idx|
      if prc.call(piv, array[idx]) == 1
        array[idx], array[i + 1] = array[i + 1], array[idx]
        i += 1
      end
    end
    array[i], array[start] = array[start], array[i]
    return i
  end
end
