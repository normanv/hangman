require_relative '../lib/hangman_model'
require_relative '../lib/console_presenter'

DICTIONARY_PATH = '/usr/share/dict/words'
v1 = ARGV[0]

def random_line_number
  number_of_line = IO.readlines(DICTIONARY_PATH).size
  random_line = rand(1..number_of_line)
end

def get_random_word
  IO.readlines(DICTIONARY_PATH).sample
end

if v1 == "--random"
  game = Hangman.new(ConsolePresenter.new, get_random_word)
else
  game = Hangman.new(ConsolePresenter.new)
end

game.start
