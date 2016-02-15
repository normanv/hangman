class AcceptableGuess
  attr_reader :value
  ACCEPTABLE = ('a'..'z').to_a + ('A'..'Z').to_a + ['-']

  def initialize(view)
    @value = view.read_guess(false)
    while !guess_is_acceptable?(@value)
      @value =view.read_guess(true)
    end
  end

  private

  def guess_is_acceptable?(guess)
    ACCEPTABLE.include?(guess)
  end

end
