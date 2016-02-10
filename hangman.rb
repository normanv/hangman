class Hangman
  #private protected public ???
  #attr_reader/writer/accessor
  #attr_reader :attribute_name
  NUMBER_OF_TRY = 6
  def initialize
    @word = gets
    @word = @word.strip
    @guesses = Array.new(0)
    @misses = Array.new(0)
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
    @guesses.length == @word.chars.uniq.length
  end

  def lost?
    @misses.length == NUMBER_OF_TRY
  end

  def running?
    !won? && !lost?
  end

  def start
    puts
    while (running?) do
      print "Guess : "
      guess = gets
      guess = guess.strip
      #analyse the input to see if it s part of the word
      if @word.count(guess) > 0
        @guesses.push(guess)
      else
        @misses.push(guess)
      end
      print_game_status
    end
    return won?
  end
end

puts "Hello game master !"
print "Please give a word to guess for the player : "
game = Hangman.new
print "Thank you, now give the screen to the player =)"
sleep 1
system "clear"
print "Welcome to the hangman game, you have to guess the word chosen by the master."
result = game.start
puts result ? "You win" : "You lose"
result ? puts("You win") : puts("You lose")
