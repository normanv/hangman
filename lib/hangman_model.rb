#require 'console_presenter'
require_relative 'acceptable_word'
require_relative 'acceptable_guess'

class Hangman_model
  #attr_reader/writer/accessor
  attr_reader :word, :guesses, :misses, :view
  ACCEPTABLE = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']

  def initialize(view, word = nil, number_of_tries = 6)
    @view = view
    @word = AcceptableWord.new(word, @view).value
    @guesses = []
    @misses = []
    @max_tries = number_of_tries
  end

  def guess(guess)
    if @word.include?(guess) && !@guesses.include?(guess)
      @guesses << guess
    else
      @misses << guess
    end
  end
  # correct_guesses = @quesses.select { |g| @word.include?(g) }
  # incorrect_guesses = @guesses.reject { |g| @word.include?(g) }

  def running?
    !won? && !lost?
  end

  def won?
    @guesses.length == @word.chars.uniq.length
  end

  def lost?
    @misses.length == @max_tries
  end

  def start
    @view.game_start
    @view.game_status(self)
    while running? do
      guess = AcceptableGuess.new(@view).value
      guess(guess)
      @view.game_status(self)
    end
    @view.game_end(self)
  end

end
