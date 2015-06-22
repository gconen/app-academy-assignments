def caesar(string, key)
  array = string.chars.map do |char|
    key.times do
      char = shift_by_one(char)
    end
    char
  end

  array.join('')
end

def shift_by_one(char)
  if char =~ /[a-y]/
    return char.next
  elsif char == 'z'
    return 'a'
  else
    return char
  end
end

p caesar('hello', 3)
