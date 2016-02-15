require './hangman_model'
require './hangman_view'

class Hangman_controller
  attr_reader :model
  ACCEPTABLE = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']

  def initialize(word = "",number_of_tries = 6)
    @view = Hangman_view.new
    if word == ""
      @view.word_input
      @model = Hangman_model.new(read_word, number_of_tries)
    else
      @model = Hangman_model.new(word, number_of_tries)
    end
    @view.model = @model
  end

  def read_word
    word = get_input("")
    while !word_is_acceptable?(word)
      word = get_input("The word does not respect the game rules, please write something else : ")
    end
    word
  end

  def read_guess
    guess = get_input("Guess : ")
    while !guess_is_acceptable?(guess)
      guess = get_input("Sorry buddy but the guess can only be a letter\nGuess : ")
    end
    guess
  end

  def start
    @view.game_start
    @view.game_status
    while @model.running? do
      guess = read_guess
      @model.analyze_guess(guess)
      @view.game_status
    end
    @view.game_end
  end

  private

  def word_is_acceptable?(word)
    word.each_char.all?  {|character| ACCEPTABLE.include?(character)}
  end

  def guess_is_acceptable?(guess)
    ACCEPTABLE.include?(guess)
  end

  def get_input(header)
    print header
    input = gets.strip.upcase
    input
  end
end
