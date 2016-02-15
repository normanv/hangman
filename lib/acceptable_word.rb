class AcceptableWord
  ACCEPTABLE = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']
  attr_reader :value
  def initialize(word = nil,view)
    @view = view
    if !word
      @value = read_word_from_user
    else
      @value = get_word_from_constructor(word)
    end
  end

  private

  def read_word_from_user
    word = @view.read_word(false)
    while !word_is_acceptable?(word)
      word = @view.read_word(true)
    end
    word
  end

  def get_word_from_constructor(word)
    if !word_is_acceptable?(word)
      raise 'The word was incorrect, end of the game'
    else
      word
    end
  end

  def word_is_acceptable?(word)
    !word.empty? &&
    word.each_char.all?  {|character| ACCEPTABLE.include?(character)} 
  end

end
