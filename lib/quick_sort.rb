require 'byebug';
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array[0]
    left = array[1..-1].select{ |el| el < pivot}
    right = array[1..-1].select{ |el| el >= pivot}
    return self.sort1(left) + [pivot] + self.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new {|a,b| a <=> b}
    return [] if length < 1
    pivot_idx = self.partition(array, start, length, &prc)
    left = pivot_idx - start
    right = length - (left + 1)

    self.sort2!(array, start, left, &prc)
    self.sort2!(array, pivot_idx + 1, right, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|a,b| a <=> b}
    pivot = array[start]
    pivot_idx = start
    i = start + 1
    while i < start + length
      if prc.call(pivot, array[i]) == 1
        array[i], array[pivot_idx + 1] = array[pivot_idx + 1], array[i]
        pivot_idx += 1
      end
      i += 1
    end

    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    return pivot_idx
  end
end
