def concatenate(string_array)
  string_array.inject {|memo, string| memo += string }
end

p concatenate(["Yay ", "for ", "strings!"])
