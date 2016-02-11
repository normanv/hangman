require './hangman'

def prepare(game)
  puts "Hello game master !"
  print "Please give a word to guess for the player : "
  game.initialize_word("")
  print "Thank you, now give the screen to the player =)"
  game
end

def start(game)
  puts "Welcome to the hangman game, you have to guess the word chosen by the master."
  game.print_game_status
  while game.running? do
    guess = game.read_guess
    game.analyze_guess(guess)
    game.print_game_status
  end
  game.won?
end

#game = Hangman.new(6)
game = Hangman.new

prepare(game)
system "clear"
result = start(game)
result ? puts("You win !") : puts("You lose !")
