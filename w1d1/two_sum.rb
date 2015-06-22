class Array
  def two_sum
    answer_arr = []
    self.each_with_index do |element1, index1|
      self.each_with_index do |element2, index2|
        next if index1 >= index2
        answer_arr << [index1, index2] if element1 + element2 == 0
      end
    end
    answer_arr
  end
end

p [-1, 0, 2, -2, 1].two_sum
