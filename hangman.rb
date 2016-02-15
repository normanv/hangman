class Hangman
  #attr_reader/writer/accessor
  #attr_reader :attribute_name
  attr_reader :word

  ACCEPTABLE = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']
  def initialize(number_of_tries = 6)
    @word = ""
    @guesses = []
    @misses = []
    @number_of_tries = number_of_tries
  end

  def read_word
    @word = get_input("")
    while !word_is_acceptable?(@word)
      @word = get_input("The word does not respect the game rules, please write something else : ")
    end
    @word
  end

  def print_game_status
    puts "Word :" + generate_word_view
    puts "Misses : " + @misses.join(',')
  end

  def read_guess
    guess = get_input("Guess : ")
    while !guess_is_acceptable?(guess)
      guess = get_input("Sorry buddy but the guess can only be a letter\nGuess : ")
    end
    guess
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

  private

  def word_is_acceptable?(word)
    word.each_char.all?  {|character| ACCEPTABLE.include?(character)}
  end

  def guess_is_acceptable?(guess)
    ACCEPTABLE.include?(guess)
  end

  def get_input(header)
    print header
    @word = gets.strip.upcase
  end

  def generate_word_view
    word_view = ""
    @word.each_char do |character|
      if @guesses.include?(character)
        word_view << character
      else
        word_view << '_'
      end
    end
    word_view
  end

end
