class Array
  def my_each(&prc)
    self.count.times do |i|
      prc.call(self[i])
    end
  end

  def my_each_with_index(&prc)
    self.count.times do |i|
      prc.call(self[i], i)
    end
  end

  def my_map(&prc)
    result = []
    self.my_each do |el|
      result << prc.call(el)
    end
    result
  end

  def my_select(&prc)
    result = []
    self.my_each do |el|
      result << el if prc.call(el)
    end
    result
  end

  def my_inject(&prc)  #{|accum, elem|}
    # arr = self.dup
    # accum = arr.shift
    accum = arr.first
    arr.drop(1).my_each do |el|
      accum = prc.call(accum, el)
    end
    accum
  end

  def my_sort!(&prc)
    # p prc
    # if prc.nil?
    prc ||= Proc.new { |a, b| a <=> b }
    # end
    sorted = false
    until sorted
      sorted = true
      self.my_each_with_index do |el, index|
        next if index == self.count - 1
        if prc.call(el,self[index + 1]) > 0
          sorted = false
          self[index], self[index + 1] = self[index + 1], self[index]
        end
      end
    end
    
    self
  end

  def my_sort(&prc)
    self.dup.my_sort!(&prc)
  end
end

a = [0,1,2,3,4,5]
b = [5,4,3,2,1]

# a.my_each do |el|
#   puts el
# end

#p b.my_sort!

# p b.my_sort
#
# p b

a.my_sort! do |a,b|
    b <=> a
  end


p a

# p a.my_map { |el| el + 1 }
#
# p a.my_select { |el| el % 2 == 0 }
#
# p a.my_inject { |sum, i| sum + i}
