class AcceptableWord
  ACCEPTABLE_CHARS = ('A'..'Z').to_a + ['-']

  def initialize(view)
    @view = view
  end

  def call(word=nil)
    if !word
      read_word_from_user
    else
      check_word?(word.strip.upcase)
    end
  end

  private

  def read_word_from_user
    word = @view.read_word(first_call: true)
    while !word_is_acceptable?(word)
      word = @view.read_word(first_call: false)
    end
    word
  end

  def check_word?(word)
    if !word_is_acceptable?(word)
      raise 'The word was incorrect, end of the game'
    else
      word
    end
  end

  def word_is_acceptable?(word)
    !word.empty? &&
    word.each_char.all?  {|character| ACCEPTABLE_CHARS.include?(character)}
  end

end
