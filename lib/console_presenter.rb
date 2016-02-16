class ConsolePresenter
  def initialize
  end

  def print_welcome
    system "reset"
    puts "Welcome to the hangman game, you have to guess the word chosen by the master."
  end

  def print_game_status(model)
    puts "Word :" + current_word_status(model)
    puts "Misses : " + model.misses.join(',')
  end

  def print_game_end(model)
    model.won? ? puts("You win !") : puts("You lose ! The word was " + model.word)
  end

  def read_word(first_call: true)
    if first_call
      word = get_input("Please give a word to guess for the player : ")
    else
      word = get_input("The word does not respect the game rules, please write something else : ")
    end
    word
  end

  def read_guess(first_call: true)
    if first_call
      guess = get_input("Guess : ")
    else
      guess = get_input("Sorry buddy but the guess can only be a letter\nGuess : ")
    end
    guess.strip.upcase
  end

  private

  def current_word_status(model)
    #[1, 2, 3].map { |n| n * 2 } # => [2, 4, 6]
    (model.word.chars.map { |character| model.guesses.include?(character) ? character : "_" }).join
  end

  def get_input(header)
    print header
    input = STDIN.gets.strip.upcase
    input
  end
end
