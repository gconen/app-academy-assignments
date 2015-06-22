def super_print(string, options = {})
  string = string.dup
  default = {
    times: 1,
    upcase: false,
    reverse: false
  }
  options = default.merge(options)

  string.upcase! if options[:upcase]
  # if options[:upcase]
  #   string = string.upcase
  # end

  if options[:reverse]
    string = string.reverse
  end

  puts string * options[:times]
end

super_print("Hello")                                    #=> "Hello"
super_print("Hello", :times => 3)                       #=> "Hello" 3x
super_print("Hello", :upcase => true)                   #=> "HELLO"
super_print("Hello", :upcase => true, :reverse => true) #=> "OLLEH"

options = {}
super_print("hello", options)
# options shouldn't change.
