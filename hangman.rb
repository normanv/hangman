class Hangman
  #private protected public ???
  #attr_reader/writer/accessor
  #attr_reader :attribute_name
  NUMBER_OF_TRY = 6
  def initialize
    @word = ''''
    @guesses = []
    @misses = []
  end

  def initialize_word(word_to_guess)
    if word_to_guess && word_to_guess != ""
      @word = word_to_guess
    else
      @word = gets
    end
    @word = @word.strip.upcase
  end

  def print_game_status
    print "Word :"
    @word.each_char do |c|
      if @guesses.include?(c)
        print c
      elsif c == ' '
        print ' '
      else
        print '_'
      end
    end
    puts
    puts "Misses : " + @misses.join(',')
  end

  def won?
    @guesses.length == @word.delete(' ').chars.uniq.length
  end

  def lost?
    @misses.length == NUMBER_OF_TRY
  end

  def running?
    !won? && !lost?
  end

  def check_guess(guess)
    acceptable = ('a'..'z').to_a + ('0'..'9').to_a + ['-']
    acceptable.include?(guess)
  end

  def read_guess
    print "Guess : "
    guess = gets
    guess = guess.strip.upcase
    while !check_guess(guess)
      puts "Sorry buddy but the guess can only be a letter or a number"
      print "Guess : "
      guess = gets
      guess = guess.strip.upcase
    end
    return guess
  end

  def analyze_guess(guess)
    if @word.count(guess) > 0
      @guesses.push(guess)
    else
      @misses.push(guess)
    end
  end

  def start
    print_game_status
    while running? do
      guess = read_guess
      analyze_guess(guess)
      print_game_status
    end
    won?
  end
end
