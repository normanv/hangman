# game_spec.rb
require './hangman'

RSpec.describe Hangman do
  let(:game) { Hangman.new }

  describe "#guess_is_acceptable" do
      before do
        game.initialize_word("hello")
      end

      it "return true for one letter" do
        expect(game.guess_is_acceptable?("a")).to eq(true)
      end

      it "return true for one capital letter" do
        expect(game.guess_is_acceptable?("A")).to eq(true)
      end

      it "return true for a dash" do
        expect(game.guess_is_acceptable?("-")).to eq(true)
      end

      it "return false for more than one character" do
        expect(game.guess_is_acceptable?("aa")).to eq(false)
      end

      it "return false for more than one digit" do
        expect(game.guess_is_acceptable?("12")).to eq(false)
      end

      it "return false for no character" do
        expect(game.guess_is_acceptable?("")).to eq(false)
      end

      it "return false for carriage return character" do
        expect(game.guess_is_acceptable?("\r")).to eq(false)
      end

      it "return false for a line feed" do
        expect(game.guess_is_acceptable?("\n")).to eq(false)
      end

      it "return false for a space" do
        expect(game.guess_is_acceptable?(" ")).to eq(false)
      end
  end

  describe "#word_is_acceptable" do

    it "return true for one word" do
      expect(game.word_is_acceptable?("hello")).to eq(true)
    end

    it "return true for compound word" do
      expect(game.word_is_acceptable?("geek-friendly")).to eq(true)
    end

    it "return false for two words" do
      expect(game.word_is_acceptable?("hello buddy")).to eq(false)
    end

    it "return false for incorrect symbol in the word" do
      expect(game.word_is_acceptable?("hello?")).to eq(false)
    end

    it "return false for number in the word" do
      expect(game.word_is_acceptable?("hello2")).to eq(false)
    end
  end

  context "all the letter in the word are guessed wit 0 mistakes" do
    let(:game) { Hangman.new }
    before do

      game.initialize_word("hello")
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
    let(:game) { Hangman.new }
    before do
      game.initialize_word("hello")
      game.analyze_guess('H')
      game.analyze_guess('E')
      game.analyze_guess('L')
      game.analyze_guess('O')
    end
    it ("win") {expect(game.won?).to eq(true)}
    it ("not lose") {expect(game.lost?).to eq(false)}
    it ("stop running") {expect(game.running?).to eq(false)}
  end

  context "all the letter in the word are missed" do
    let(:game) { Hangman.new(3) }
    before do
      game.initialize_word("hello")
      game.analyze_guess('A')
      game.analyze_guess('B')
      game.analyze_guess('C')
    end
    it ("not win") {expect(game.won?).to eq(false)}
    it ("lose") {expect(game.lost?).to eq(true)}
    it ("stop running") {expect(game.running?).to eq(false)}
  end

  context "all the letter in the word are guessed with less mistakes than max" do
    let(:game) { Hangman.new(3) }
    before do
      game.initialize_word("hello")
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
    let(:game) { Hangman.new(3) }
    before do
      game.initialize_word("hello")
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
    let(:game) { Hangman.new(3) }
    before do
      game.initialize_word("hello")
      game.analyze_guess('H')
      game.analyze_guess('E')
      game.analyze_guess('L')
      game.analyze_guess('L')
    end
    it ("not win") {expect(game.won?).to eq(false)}
    it ("not lose") {expect(game.lost?).to eq(false)}
    it ("running") {expect(game.running?).to eq(true)}
  end
  context

end

### wrong type param
