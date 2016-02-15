#require 'console_presenter'

class Hangman_model
  #attr_reader/writer/accessor
  attr_reader :word
  attr_reader :guesses
  attr_reader :misses
  attr_reader :view

  def initialize(view, word = "", number_of_tries = 6)
    @view = view
    if word == ""
      @word = @view.word_input
    else
      @word = word
    end
    @guesses = []
    @misses = []
    @number_of_tries = number_of_tries
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
    @misses.length == @number_of_tries
  end

  def start
    @view.game_start
    @view.game_status(self)
    while running? do
      guess = @view.read_guess
      guess(guess)
      @view.game_status(self)
    end
    @view.game_end(self)
  end

end
