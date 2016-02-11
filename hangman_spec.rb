# game_spec.rb
require './hangman'

RSpec.describe Hangman do
  let(:game) { Hangman.new }

  describe "#check_guess" do
      before do
        game.initialize_word("hello")
      end

      it "return true for one letter" do
        expect(game.check_guess?("a")).to eq(true)
      end

      it "return true for one capital letter" do
        expect(game.check_guess?("A")).to eq(true)
      end

      it "return true for a dash" do
        expect(game.check_guess?("-")).to eq(true)
      end

      it "return false for more than one character" do
        expect(game.check_guess?("aa")).to eq(false)
      end

      it "return false for more than one digit" do
        expect(game.check_guess?("12")).to eq(false)
      end

      it "return false for no character" do
        expect(game.check_guess?("")).to eq(false)
      end

      it "return false for carriage return character" do
        expect(game.check_guess?("\r")).to eq(false)
      end

      it "return false for a line feed" do
        expect(game.check_guess?("\n")).to eq(false)
      end

      it "return false for a space" do
        expect(game.check_guess?(" ")).to eq(false)
      end
  end

  describe "#check_word" do

    it "return true for one word" do
      expect(game.check_word?("hello")).to eq(true)
    end

    it "return true for compound word" do
      expect(game.check_word?("geek-friendly")).to eq(true)
    end

    it "return false for two words" do
      expect(game.check_word?("hello buddy")).to eq(false)
    end

    it "return false for incorrect symbol in the word" do
      expect(game.check_word?("hello?")).to eq(false)
    end

    it "return false for number in the word" do
      expect(game.check_word?("hello2")).to eq(false)
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
