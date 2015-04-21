def substrings(string)
  subs = []
  (0...string.length).each do |i|
    (i...string.length).each do |j|
      subs << string[i..j] unless subs.include?(string[i..j])
    end
  end
  subs
end

# def substrings(string)
#   substrings_arr = [string]
#   if string.length > 1
#     substrings_arr.concat(recurse_substrings(string))
#     substrings_arr.uniq!
#   end
#   substrings_arr
# end
#
# def recurse_substrings(string)
#   from_end = substrings(string[1..-1])
#   from_start = substrings(string[0..-2])
#   from_start.concat(from_end)
# end

def is_word?(string, dictionary = Dictionary.new)
  dictionary.include?(string)
end

def subwords(string)
  substrings_arr = substrings(string)
  dictionary = Dictionary.new
  substrings_arr.select {|word| dictionary.include?(word)}
end

class Dictionary
  attr_reader :words

  def initialize(source = "dictionary.txt")
    @words = File.readlines(source)
    @words.map! {|word| word.chomp }
  end

  def include?(word)
    @words.include?(word.downcase)
  end
end

my_dictionary = Dictionary.new

p subwords("concatenate")
