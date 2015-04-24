require "set"
class WordChainer
  LETTERS = ('a'..'z')

  def initialize(dictionary = 'dictionary.txt')
    @dictionary = Set.new(File.readlines(dictionary).map(&:chomp))
    @start =  Time.now
  end

  def adjacent?(word1, word2)
    mismatch = false
    (0...word1.length).each do |i|
      next if word1[i] == word2[i]
      return false if mismatch
      mismatch = true
    end
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

  def check_dictionary
    new_words = []
    @possible_words.each do |word|
      @current_words.each do |current_word|
        next if @all_seen_words.include?(word)
        if adjacent?(word, current_word)
          @all_seen_words[word] = current_word
          new_words << word
        end
      end
    end

    new_words
  end

  def explore_current_words(target)
    new_current_words = []

    # @current_words.each do |word|
    #   adjacents = adjacent_words(word)
    #   adjacents.each do |w|
    #     next if @all_seen_words.include?(w)
    #     new_current_words << w
    #     @all_seen_words[w] = word
    #   end
    # end

    new_current_words = check_dictionary

    p @current_words.length
    @current_words = new_current_words
  end

  def prune_dictionary(word)
    @possible_words = @dictionary.select do |entry|
      entry.length == word.length
    end
  end

  def run(source, target)
    @current_words = [source]
    @all_seen_words = { source => nil }

    prune_dictionary(source)
    p @possible_words.count

    until @current_words.empty? || @current_words.include?(target)
      explore_current_words(target)
    end

    path = build_path(target)
    puts Time.now - @start
    path.nil? ? "No path from #{source} to #{target}." : path.join(" => ")
  end
end

w = WordChainer.new
puts w.run('market', 'toilet')
