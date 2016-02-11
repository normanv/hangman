class Hangman
  #private protected public ???
  #attr_reader/writer/accessor
  #attr_reader :attribute_name

  def initialize(number_of_tries = 6)
    @word = ""
    @guesses = []
    @misses = []
    @acceptable = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']
    @number_of_tries = number_of_tries
  end

  private

  def word_is_acceptable?(word)
    word.each_char.all?  {|character| @acceptable.include?(character)}
  end

  def guess_is_acceptable?(guess)
    @acceptable.include?(guess)
  end

  public

  def read_word
    @word = gets
    @word = @word.strip.upcase

    while !word_is_acceptable?(@word)
      print "The word does not respect the game rules, please write something else : "
      @word = gets
      @word = @word.strip.upcase
    end
  end

  def print_game_status
    print "Word :"
    @word.each_char do |c|
      if @guesses.include?(c)
        print c
      else
        print '_'
      end
    end
    puts
    puts "Misses : " + @misses.join(',')
  end

  def word
    @word
  end

  def read_guess
    print "Guess : "
    guess = gets
    guess = guess.strip.upcase
    while !guess_is_acceptable?(guess)
      puts "Sorry buddy but the guess can only be a letter"
      print "Guess : "
      guess = gets
      guess = guess.strip.upcase
    end
    return guess
  end

  def analyze_guess(guess)
    if @word.count(guess) > 0 && !@guesses.include?(guess)
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
