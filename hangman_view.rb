require './hangman_model'

class Hangman_view
  attr_writer :model
  def initialize
  end

  def word_input
    puts "Hello game master !"
    print "Please give a word to guess for the player : "
  end

  def game_start
    system "reset"
    puts "Welcome to the hangman game, you have to guess the word chosen by the master."
  end

  def game_status
    puts "Word :" + generate_word
    puts "Misses : " + @model.misses.join(',')
  end

  def game_end
    @model.won? ? puts("You win !") : puts("You lose ! The word was " + game.word)
  end

  private

  def generate_word
    word_view = ""
    @model.word.each_char do |character|
      if @model.guesses.include?(character)
        word_view << character
      else
        word_view << '_'
      end
    end
    word_view
  end
end
