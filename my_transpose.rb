def my_transpose(input)
  length = input.length
  new_array = Array.new(length) { [] }
  input.each_with_index do |subary, idx|
    subary.each_with_index do |el, sub_i|
      new_array[sub_i][idx] = el
    end
  end
  new_array
end

rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

p my_transpose(rows)
