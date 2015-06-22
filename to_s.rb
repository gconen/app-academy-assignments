hash = {
  10 => 'A',
  11 => 'B',
  12 => 'C',
  13 => 'D',
  14 => 'E',
  15 => 'F'
}

(0..9).each do |number|
  hash[number] = "#{number}"
end

HASH = hash

def num_to_s(num, base)
  #   num_string = ""
#   power = 0
#   while (base ** power) < num
#     digit = (num / (base ** power)) % base
#     num_string = hash[digit] + num_string
#     power += 1
#   end
#   num_string

  digit = num % base
  if num < base
    return HASH[digit]
  end
  num_to_s((num - digit) / base, base) + HASH[digit]


end

p num_to_s(234, 2)
p num_to_s(4544, 2)
p num_to_s(237674, 2)
p num_to_s(2314, 2)
