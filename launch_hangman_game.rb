puts "Hello game master !"
print "Please give a word to guess for the player : "
game = Hangman.new
game.initialize_word("test")
print "Thank you, now give the screen to the player =)"
sleep 1
system "clear"
puts "Welcome to the hangman game, you have to guess the word chosen by the master."
result = game.start
#this also work : puts result ? "You win" : "You lose"
result ? puts("You win !") : puts("You lose !")
