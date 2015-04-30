class Array
  def v_add(other_arr)
    self.map.with_index { |el, i| self[i] + other_arr[i] }
  end

  def v_mult(num)
    self.map{ |el| el * num }
  end
end
