module ApiFilter
  class Token
    attr_reader :token_type, :lexeme, :position

    def initialize(token_type, lexeme = nil, position = nil)
      @token_type = token_type
      @lexeme = lexeme
      @position = position
    end

    def eql?(other)
      self == other
    end

    def ==(other)
      (
        (token_type == other.token_type) &&
        (lexeme == other.lexeme) &&
        (position == position)
      )
    end
  end
end