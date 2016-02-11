class Hangman
  #private protected public ???
  #attr_reader/writer/accessor
  #attr_reader :attribute_name

  NUMBER_OF_TRY = 6
  def initialize
    @word = ''''
    @guesses = []
    @misses = []
    @acceptable = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']
  end

  def check_word?(word)
    word.each_char.all?  {|c| @acceptable.include?(c)}
  end

  def initialize_word(word_input)
    if word_input && word_input != ""
      @word = word_input
    else
      @word = gets
    end
    @word = @word.strip.upcase

    while !check_word?(@word)
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

  def won?
    @guesses.length == @word.delete(' ').chars.uniq.length
  end

  def lost?
    @misses.length == NUMBER_OF_TRY
  end

  def running?
    !won? && !lost?
  end

  def check_guess?(guess)
    @acceptable.include?(guess)
  end

  def read_guess
    print "Guess : "
    guess = gets
    guess = guess.strip.upcase
    while !check_guess?(guess)
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
