def bubble_sort!(array)
  needs_sorting = true
  while needs_sorting
    needs_sorting = false
    array.each_index do |index|
      next if index == 0
      if array[index] < array[index - 1]
        needs_sorting = true
        array[index], array[index - 1] = array[index - 1], array[index]
      end
    end
  end
  array
end

p bubble_sort!([4, 2, 3, 1, 0])
p bubble_sort!([1, 2, 3, 0, 4])
p bubble_sort!([0, 1, 2, 3, 4])
