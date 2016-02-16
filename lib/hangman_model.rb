require_relative 'acceptable_word'
require_relative 'ask_user_for_guess'

class Hangman
  attr_reader :word, :guesses, :misses, :view

  def initialize(view, word = nil, number_of_tries = 6)
    @view = view
    @word = AcceptableWord.new(@view).call(word)
    @guesses = []
    @misses = []
    @max_tries = number_of_tries
  end

  def guess(guess)
    if !running?
      puts "the game is finish you can not make guess"
      return
    end
    if @word.include?(guess) && !@guesses.include?(guess)
      @guesses << guess
    else
      @misses << guess
    end
  end

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
    @view.print_welcome
    @view.print_game_status(self)
    while running? do
      guess = AskUserForGuess.new(@view).call
      guess(guess)
      @view.print_game_status(self)
    end
    @view.print_game_end(self)
  end

end
