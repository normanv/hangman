#require './hangman_model'

class Console_presenter
  attr_writer :model
  ACCEPTABLE = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']
  def initialize

  end

  def word_input
    puts "Hello game master !"
    print "Please give a word to guess for the player : "
    read_word
  end

  def game_start
    system "reset"
    puts "Welcome to the hangman game, you have to guess the word chosen by the master."
  end

  def game_status(model)
    puts "Word :" + generate_word(model).join
    puts "Misses : " + model.misses.join(',')
  end

  def game_end(model)
    model.won? ? puts("You win !") : puts("You lose ! The word was " + model.word)
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

  private

  def generate_word(model)
    #[1, 2, 3].map { |n| n * 2 } # => [2, 4, 6]
    model.word.chars.map { |character| model.guesses.include?(character) ? character : "_" }
  end

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
