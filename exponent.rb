def exp1(base, power)
  return 1 if power == 0
  base * exp1(base, power-1)
end

def exp2(base, power)
  return 1 if power == 0
  if power % 2 == 0
    square(exp2(base, power / 2))
  else
    base * exp2(base, power - 1)
  end
end

def square(num)
  num * num
end
