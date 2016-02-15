require '../lib/hangman_model'
require '../lib/console_presenter'

game = Hangman_model.new(Console_presenter.new, "")
game.start
