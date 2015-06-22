class Array
  def my_each
    i = 0
    while i < self.length
      yield self[i]
      i += 1
    end
    return self
  end
end

[1, 2, 3].my_each { |num| p num }
