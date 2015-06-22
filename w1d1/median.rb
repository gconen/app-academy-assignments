class Array
  def median
    sorted = self.sort
    l = self.length
    if l.odd?
      sorted[l/2]
    else
      (sorted[l/2] + sorted[l/2 -1 ]) /2.0
    end
  end
end

p [1,2,3,4,5].median
