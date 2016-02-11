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

end

### wrong type param
