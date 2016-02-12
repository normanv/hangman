# game_spec.rb
require './hangman'

RSpec.describe Hangman do
  let(:game) { Hangman.new }

  describe "#guess_is_acceptable" do
      before do
        allow(game).to receive(:gets).and_return('hello')
        game.read_word
      end

      it "return the capitalize letter when user write a single letter" do
        allow(game).to receive(:gets).and_return('a')
        expect(game.read_guess).to eq('A')
      end

      it "return the letter when user write a capital letter" do
        allow(game).to receive(:gets).and_return('A')
        expect(game.read_guess).to eq('A')
      end

      it "return a dash when user write for a dash" do
        allow(game).to receive(:gets).and_return('-')
        expect(game.read_guess).to eq('-')
      end

      it "return false for more than one character" do
        allow(game).to receive(:gets).and_return('aa', 'a')
        expect { game.read_guess }.to output("Guess : Sorry buddy but the"\
        " guess can only be a letter\nGuess : ").to_stdout
      end

      it "return false for a digit" do
        allow(game).to receive(:gets).and_return('1', 'a')
        expect { game.read_guess }.to output("Guess : Sorry buddy but the"\
        " guess can only be a letter\nGuess : ").to_stdout
      end

      it "return false for no character" do
        allow(game).to receive(:gets).and_return('', 'a')
        expect { game.read_guess }.to output("Guess : Sorry buddy but the"\
        " guess can only be a letter\nGuess : ").to_stdout
      end

      it "return false for carriage return character" do
        allow(game).to receive(:gets).and_return('\r', 'a')
        expect { game.read_guess }.to output("Guess : Sorry buddy but the"\
        " guess can only be a letter\nGuess : ").to_stdout
      end

      it "return false for a line feed" do
        allow(game).to receive(:gets).and_return('\n', 'a')
        expect { game.read_guess }.to output("Guess : Sorry buddy but the"\
        " guess can only be a letter\nGuess : ").to_stdout
      end

      it "return false for a space" do
        allow(game).to receive(:gets).and_return(' ', 'a')
        expect { game.read_guess }.to output("Guess : Sorry buddy but the"\
        " guess can only be a letter\nGuess : ").to_stdout
      end
  end

  describe "#word_is_acceptable" do

    it "return a correct word with capital letters" do
      allow(game).to receive(:gets).and_return('hello')
      expect(game.read_word).to eq("HELLO")
    end

    it "return a correct compound word with capital letters" do
      allow(game).to receive(:gets).and_return('geek-friendly')
      expect(game.read_word).to eq("GEEK-FRIENDLY")
    end

    it "ask for a new word when sending two words" do
      allow(game).to receive(:gets).and_return('hello buddy', 'hello')
      expect { game.read_word }.to output('The word does not respect the game '\
      'rules, please write something else : ').to_stdout
    end

    it "ask for a new word when sendingsymbol in the word" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('hello?', 'hello')
      expect { game.read_word }.to output('The word does not respect the game '\
      'rules, please write something else : ').to_stdout
    end

    it "ask for a new word when sending a word that contains a digit" do
      allow_any_instance_of(Kernel).to receive(:gets).and_return('hello2', 'hello')
      expect { game.read_word }.to output('The word does not respect the game '\
      'rules, please write something else : ').to_stdout
    end
  end

  context "all the letter in the word are guessed wit 0 mistakes" do
    before do
      allow(game).to receive(:gets).and_return('hello')
      game.read_word
      game.analyze_guess('H')
      game.analyze_guess('E')
      game.analyze_guess('L')
      game.analyze_guess('O')
    end
    it ("win") {expect(game.won?).to eq(true)}
    it ("not lose") {expect(game.lost?).to eq(false)}
    it ("stop running") {expect(game.running?).to eq(false)}
  end

  context "all the letter in the word are guessed with 0 mistakes" do
    before do
      allow(game).to receive(:gets).and_return('hello')
      game.read_word
      game.analyze_guess('H')
      game.analyze_guess('E')
      game.analyze_guess('L')
      game.analyze_guess('O')
    end
    it ("win") {expect(game.won?).to eq(true)}
    it ("not lose") {expect(game.lost?).to eq(false)}
    it ("stop running") {expect(game.running?).to eq(false)}
  end

  context "when there are 3 tries" do
    let(:game) { Hangman.new(3) }

    context "all the letter in the word are missed" do
      before do
        allow(game).to receive(:gets).and_return('hello')
        game.read_word
        game.analyze_guess('A')
        game.analyze_guess('B')
        game.analyze_guess('C')
      end

      it ("not win") {expect(game.won?).to eq(false)}

      it ("lose") {expect(game.lost?).to eq(true)}

      it ("stop running") {expect(game.running?).to eq(false)}
    end

    context "all the letter in the word are guessed with less mistakes than max" do
      before do
        allow(game).to receive(:gets).and_return('hello')
        game.read_word
        game.analyze_guess('A')
        game.analyze_guess('H')
        game.analyze_guess('B')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('O')
      end

      it ("win") {expect(game.won?).to eq(true)}

      it ("not lose") {expect(game.lost?).to eq(false)}

      it ("stop running") {expect(game.running?).to eq(false)}
    end

    context "some letter in the word are guessed with mistakes exceding the limit" do
      before do
        allow(game).to receive(:gets).and_return('hello')
        game.read_word
        game.analyze_guess('A')
        game.analyze_guess('H')
        game.analyze_guess('B')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('Z')
      end

      it ("not win") {expect(game.won?).to eq(false)}

      it ("lose") {expect(game.lost?).to eq(true)}

      it ("stop running") {expect(game.running?).to eq(false)}
    end

    context "user write two times the same guess without guessing the whole word" do
      before do
        allow(game).to receive(:gets).and_return('hello')
        game.read_word
        game.analyze_guess('H')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('L')
      end
      it ("not win") {expect(game.won?).to eq(false)}

      it ("not lose") {expect(game.lost?).to eq(false)}

      it ("running") {expect(game.running?).to eq(true)}
    end
  end
end
