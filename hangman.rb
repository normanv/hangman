class Hangman
  #private protected public ???
  #attr_reader/writer/accessor
  #attr_reader :attribute_name
  NUMBER_OF_TRY = 6
  def initialize
    @word = get_word
    @guesses = []
    @misses = []
  end

  def get_word
    @word = gets
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

    guess.size == 1 && acceptable.include?(guess)

    if guess.size > 1
      false
    elsif !(/\A[[:alnum:]-]\z/.match(guess))
      false
    else
      true
    end
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

puts "Hello game master !"
print "Please give a word to guess for the player : "
game = Hangman.new
print "Thank you, now give the screen to the player =)"
sleep 1
system "clear"
puts "Welcome to the hangman game, you have to guess the word chosen by the master."
result = game.start
#this also work : puts result ? "You win" : "You lose"
result ? puts("You win !") : puts("You lose !")
