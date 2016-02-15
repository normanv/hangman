# game_spec.rb
require './Hangman_controller'

RSpec.describe Hangman_controller do
  let(:game) { Hangman_controller.new("HELLO") }

  describe "#read_guess" do
    let(:read_failure_message) { "Guess : Sorry buddy but the"\
    " guess can only be a letter\nGuess : " }

    it "returns the capitalize letter when user write a single letter" do
      allow(game).to receive(:gets).and_return('a')
      expect(game.read_guess).to eq('A')
    end

    it "returns the letter when user write a capital letter" do
      allow(game).to receive(:gets).and_return('A')
      expect(game.read_guess).to eq('A')
    end

    it "returns a dash when user write for a dash" do
      allow(game).to receive(:gets).and_return('-')
      expect(game.read_guess).to eq('-')
    end

    it "asks to write again when user write for more than one character" do
      allow(game).to receive(:gets).and_return('aa', 'a')
      expect { game.read_guess }.to output(read_failure_message).to_stdout
    end

    it "asks to write again when user write a digit" do
      allow(game).to receive(:gets).and_return('1', 'a')
      expect { game.read_guess }.to output(read_failure_message).to_stdout
    end

    it "asks to write again when user write nothing" do
      allow(game).to receive(:gets).and_return('', 'a')
      expect { game.read_guess }.to output(read_failure_message).to_stdout
    end

    it "asks to write again when user write carriage return character" do
      allow(game).to receive(:gets).and_return('\r', 'a')
      expect { game.read_guess }.to output(read_failure_message).to_stdout
    end

    it "asks to write again when user write a line feed" do
      allow(game).to receive(:gets).and_return('\n', 'a')
      expect { game.read_guess }.to output(read_failure_message).to_stdout
    end

    it "asks to write again when user write a space" do
      allow(game).to receive(:gets).and_return(' ', 'a')
      expect { game.read_guess }.to output(read_failure_message).to_stdout
    end
  end

  describe "#read_word" do
    let(:game) { Hangman_controller.new("HELLO")}
    let(:read_failure_message) { 'The word does not respect the game '\
        'rules, please write something else : ' }

    it "returns a correct word with capital letters" do
      allow(game).to receive(:gets).and_return('hello')
      expect(game.read_word).to eq("HELLO")
    end

    it "returns a correct compound word with capital letters" do
      allow(game).to receive(:gets).and_return('geek-friendly')
      expect(game.read_word).to eq("GEEK-FRIENDLY")
    end

    it "asks for a new word when sending two words" do
      allow(game).to receive(:gets).and_return('hello buddy', 'hello')
      expect { game.read_word }.to output(read_failure_message).to_stdout
    end

    it "asks for a new word when sending special symbol in the word" do
      allow(game).to receive(:gets).and_return('hello?', 'hello')
      expect { game.read_word }.to output(read_failure_message).to_stdout
    end

    it "asks for a new word when sending a word that contains a digit" do
      allow(game).to receive(:gets).and_return('hello2', 'hello')
      expect { game.read_word }.to output(read_failure_message).to_stdout
    end
  end

  context "all the letter in the word are guessed wit 0 mistakes" do
    let(:game) { Hangman_controller.new("HELLO",3).model }
    before do
      game.analyze_guess('H')
      game.analyze_guess('E')
      game.analyze_guess('L')
      game.analyze_guess('O')
    end

    it "is won" do
      expect(game).to be_won
    end

    it "is not lost" do
      expect(game).not_to be_lost
    end

    it "is not running" do
      expect(game).not_to be_running
    end

  end

  context "when there are 3 tries" do
    let(:game) { Hangman_controller.new("HELLO",3).model }

    context "all the letter in the word are missed" do
      before do
        game.analyze_guess('A')
        game.analyze_guess('B')
        game.analyze_guess('C')
      end

      it "is not won" do
        expect(game).not_to be_won
      end

      it "is lost" do
        expect(game).to be_lost
      end

      it "is not running" do
        expect(game).not_to be_running
      end
    end

    context "all the letter in the word are guessed with less mistakes than max" do
      before do
        game.analyze_guess('A')
        game.analyze_guess('H')
        game.analyze_guess('B')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('O')
      end

      it "is won" do
        expect(game).to be_won
      end

      it "is not lost" do
        expect(game).not_to be_lost
      end

      it "is not running" do
        expect(game).not_to be_running
      end
    end

    context "some letter in the word are guessed with mistakes exceding the limit" do
      before do
        game.analyze_guess('A')
        game.analyze_guess('H')
        game.analyze_guess('B')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('Z')
      end

      it "is not won" do
        expect(game).not_to be_won
      end

      it "is lost" do
        expect(game).to be_lost
      end

      it "is not running" do
        expect(game).not_to be_running
      end

    end

    context "user write two times the same guess without guessing the whole word" do
      before do
        game.analyze_guess('H')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('L')
      end

      it "is not won" do
        expect(game).not_to be_won
      end

      it "is not lost" do
        expect(game).not_to be_lost
      end

      it "is running" do
        expect(game).to be_running
      end

    end

    context "user write many times the same guess and lost" do
      before do
        game.analyze_guess('H')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('L')
        game.analyze_guess('L')
        game.analyze_guess('L')
      end

      it "is not won" do
        expect(game).not_to be_won
      end

      it "is lost" do
        expect(game).to be_lost
      end

      it "is not running" do
        expect(game).not_to be_running
      end

    end

    context "user write a mix of already guessed and missed character" do
      before do
        game.analyze_guess('H')
        game.analyze_guess('E')
        game.analyze_guess('L')
        game.analyze_guess('L')
        game.analyze_guess('A')
        game.analyze_guess('B')
      end

      it "is not won" do
        expect(game).not_to be_won
      end

      it "is lost" do
        expect(game).to be_lost
      end

      it "is not running" do
        expect(game).not_to be_running
      end

    end
  end
end
