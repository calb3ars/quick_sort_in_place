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
    return array if array.length < 2
    pivot = self.partition(array, start, length, &prc)
    array[0...pivot] = self.sort2!(array[0...pivot], &prc)
    array[(pivot + 1)..-1] = self.sort2!(array[(pivot + 1)..-1], &prc)
    return array[0...pivot] + [array[pivot]] + array[(pivot + 1)..-1]
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|a,b| a <=> b}
    pivot = array[start]
    i = start
    b_index = start + 1
    while i < start + length
      if array[i] < pivot
        prc.call(array[i], pivot) != -1
        if i != b_index
          array[i], array[b_index] = array[b_index], array[i]
          # prc.call(array[i], pivot)
        end
        b_index += 1
      end
      i += 1
    end
    prc.call(array[i], pivot)
    array[start], array[b_index - 1] = array[b_index - 1], array[start]

    b_index - 1
  end
end
