# frozen_string_literal: true

require "spec_helper"

RSpec.describe ApiFilter::Lexer do
  describe '#scan_tokens' do
    context 'when filter expression is blank' do
      it 'returns an :eof token only' do
        lexer = described_class.new('')
        expect(lexer.scan_tokens).to eql([[:eof]])
      end
    end

    context 'when filter expression is present' do
      context 'with identifier token' do
        it 'returns an :identifier token' do
          lexer = described_class.new(' model.attribute')
          expect(lexer.scan_tokens).to match_array([[:identifier, 'model.attribute', 1], [:eof]])
        end
      end

      context 'with `and` operator token' do
        it 'returns an :operator token' do
          lexer = described_class.new('  and ')
          expect(lexer.scan_tokens).to match_array([[:operator, 'and', 2], [:eof]])
        end
      end
    end
  end 
end