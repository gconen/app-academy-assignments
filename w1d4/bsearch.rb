def bsearch(arr, num)
  return nil if arr.empty?

  pivot = arr.count / 2

  case arr[pivot] <=> num
  when 1
    return bsearch(arr.take(pivot), num)
  when 0
    return pivot
  when -1
    result = bsearch(arr.drop(pivot + 1), num)
    return result.nil? ? result : result + pivot + 1
  end
end
