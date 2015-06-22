def fibonacci(num)
  fibs = [0, 1]
  return fibs.take(num) if num <= 2

  # return [0] if num == 1
  # return [0, 1] if num == 2
  previous_fibonacci = fibonacci(num - 1)
  current = previous_fibonacci[-1] + previous_fibonacci[-2]
  return previous_fibonacci << current
end
