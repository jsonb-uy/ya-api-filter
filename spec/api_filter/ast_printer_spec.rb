# frozen_string_literal: true

require "spec_helper"

RSpec.describe ApiFilter::AstPrinter do
  let(:printer) { described_class.new }

  describe '#print' do
    it 'works' do
      expr = UnaryExpression.new(
        Token.new(:operator, 'not'),
        GroupingExpression.new(
          BinaryExpression.new(
            LiteralExpression.new('people.first_name'),
            Token.new(:operator, 'eq'),
            LiteralExpression.new("'john'")
          )
        )
      )

      expect(printer.print(expr)).to eql("(not (group (eq people.first_name 'john')))")
    end
  end 
end