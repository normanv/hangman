class Hangman_model
  #attr_reader/writer/accessor
  attr_reader :word
  attr_reader :guesses
  attr_reader :misses

  def initialize(word, number_of_tries)
    @word = word
    @guesses = []
    @misses = []
    @number_of_tries = number_of_tries
  end

  def analyze_guess(guess)
    if @word.include?(guess) && !@guesses.include?(guess)
      @guesses.push(guess)
    else
      @misses.push(guess)
    end
  end

  def running?
    !won? && !lost?
  end

  def won?
    @guesses.length == @word.chars.uniq.length
  end

  def lost?
    @misses.length == @number_of_tries
  end
end
