module ApiFilter
  class Lexer
    IDENTIFIER = /^[a-zA-Z_]((\.[a-zA-Z_])|(\w))*/
    DOUBLE_QUOTE_STRING_LITERAL = /^"[^\"]*"/
    SINGLE_QUOTE_STRING_LITERAL = /^'[^\'']*'/
    BOOLEAN_LITERAL = /(true)|(false)/
    NULL_LITERAL = /(null)/
    NUMERIC_LITERAL = /^[0-9]+((\.[0-9]+)|([0-9]*))/
    OPERATORS = /^((and)|(or)|(not)|(eq)|(ne)|(lt)|(le)|(gt)|(ge)|(in)|(sw)|(ew)|(contains))/
    WHITESPACE = /\s+/

    SPECIAL_TOKENS = {
      '(' => :left_paren,
      ')' => :right_paren
    }.freeze

    attr_reader :source, :tokens, :scanner

    def initialize(source)
      @source = source
      @tokens = []
      @scanner = StringScanner.new(@source)
    end

    def scan_tokens
      position = 0

      until scanner.eos?

        token_type = if (lexeme = scanner.scan(WHITESPACE))
                  position += lexeme.size
                  next
                elsif (lexeme = scanner.scan(NULL_LITERAL))
                  :null_literal
                elsif (lexeme = scanner.scan(OPERATORS))
                  :operator
                elsif (lexeme = scanner.scan(BOOLEAN_LITERAL))
                  :boolean_literal
                elsif (lexeme = scanner.scan(IDENTIFIER))
                  :identifier
                elsif (lexeme = scanner.scan(DOUBLE_QUOTE_STRING_LITERAL))
                  :string_literal
                elsif (lexeme = scanner.scan(SINGLE_QUOTE_STRING_LITERAL))
                  :string_literal
                elsif (lexeme = scanner.scan(NUMERIC_LITERAL))
                  :numeric_literal
                else
                  lexeme = scanner.getch

                  SPECIAL_TOKENS[lexeme] if SPECIAL_TOKENS[lexeme]
                end

        if token_type.nil?
          raise StandardError, "Unexpected token '#{lexeme}' detected at index #{position}."
        end

        tokens << Token.new(token_type, lexeme, position)
        position += lexeme.size
      end

      tokens << Token.new(:eof)
    end
  end
end