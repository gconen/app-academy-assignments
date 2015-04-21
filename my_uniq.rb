class Array
  def my_uniq
      arr = []
      self.each do |element|
        unless arr.include?(element)
          arr << element
        end
      end
      arr
  end
end


p [1,1,3,4,5,5].my_uniq
