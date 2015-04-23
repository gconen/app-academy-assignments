require "set"
class WordChainer
  LETTERS = ('a'..'z')

  def initialize(dictionary = 'dictionary.txt')
    @dictionary = Set.new(File.readlines(dictionary).map(&:chomp))
    @start =  Time.now
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

  def build_path(target)
    return nil unless @all_seen_words.include?(target)

    path = [target]
    previous_word = @all_seen_words[target]
    until previous_word.nil?
      path << previous_word
      previous_word = @all_seen_words[previous_word]
    end

    path.compact.reverse
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

    @current_words = new_current_words
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    until @current_words.empty? || @current_words.include?(target)
      explore_current_words(target)
    end

    path = build_path(target)
    puts Time.now - @start
    path.nil? ? "No path from #{source} to #{target}." : path.join(" => ")
  end
end

w = WordChainer.new
puts w.run('duck', 'ruby')
