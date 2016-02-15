require_relative '../lib/hangman_model'
require_relative '../lib/console_presenter'

DICTIONNARY_PATH = '/usr/share/dict/words'
v1 = ARGV[0]

def random_line_number
  number_of_line = IO.readlines(DICTIONNARY_PATH).size
  random_line = rand(1..number_of_line)
end

def get_random_word
  IO.readlines(DICTIONNARY_PATH)[random_line_number]
end

if v1 == "--random"
  game = Hangman_model.new(Console_presenter.new, get_random_word.strip.upcase)
else
  game = Hangman_model.new(Console_presenter.new)
end

game.start
