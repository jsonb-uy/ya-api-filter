# frozen_string_literal: true

require "spec_helper"

RSpec.describe ApiFilter::Lexer do
  let(:eof_token) { ApiFilter::Token.new(:eof) }

  describe '#scan_tokens' do
    context 'when filter expression is blank' do
      it 'returns an :eof token only' do
        lexer = described_class.new('')
        expect(lexer.scan_tokens).to eql([eof_token])
      end
    end

    context 'when filter expression is present' do
      context 'with identifier token' do
        it 'returns an :identifier token' do
          lexer = described_class.new(' model.attribute')
          expect(lexer.scan_tokens).to match_array([
            ApiFilter::Token.new(:identifier, 'model.attribute', 1), 
            eof_token
          ])
        end
      end

      context 'with `and` operator token' do
        it 'returns an :operator token' do
          lexer = described_class.new('  and ')
          expect(lexer.scan_tokens).to match_array([
            ApiFilter::Token.new(:operator, 'and', 2), 
            eof_token
          ])
        end
      end

      context 'with `or` operator token' do
        it 'returns an :operator token' do
          lexer = described_class.new('or')
          expect(lexer.scan_tokens).to match_array([
            ApiFilter::Token.new(:operator, 'or', 0), 
            eof_token
          ])
        end
      end

      context 'with `not` operator token' do
        it 'returns an :operator token' do
          lexer = described_class.new('     not')
          expect(lexer.scan_tokens).to match_array([
            ApiFilter::Token.new(:operator, 'not', 5), 
            eof_token
          ])
        end
      end
    end
  end 
end