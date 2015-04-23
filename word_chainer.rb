require "set"
class WordChainer
  LETTERS = ('a'..'z')

  def initialize(dictionary = 'dictionary.txt')
    @dictionary = Set.new(File.readlines(dictionary).map(&:chomp))
  end

  def adjacent_words(word)
    adjacents = []
    (0...word.length).each do |char_pos|
      LETTERS.each do |new_letter|
        next if word[char_pos] == new_letter
        new_word = word.dup
        new_word[char_pos] = new_letter
        if @dictionary.include?(new_word)
          adjacents << new_word
        end
      end
    end

    adjacents
  end

  def explore_current_words(target)
    new_current_words = []
    @current_words.each do |word|
      adjacents = adjacent_words(word)
      adjacents.each do |w|
        next if @all_seen_words.include?(w)
        new_current_words << w
        @all_seen_words[w] = word
      end
    end

    new_current_words.each do |word|
      print "#{@all_seen_words[word]} > "
      print "#{word}, "
    end
    puts "\n\n"
    @current_words = new_current_words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty?
      explore_current_words(target)
    end
  end
end
