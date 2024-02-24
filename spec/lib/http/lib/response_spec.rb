# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Http::Lib::Response do
  describe '#json!' do
    context 'when body is JSON' do
      it 'returns json formatted' do
        raw = '{"name":"any"}'

        response = described_class.new(body: raw)

        expect(response.json!).to eq(JSON.parse(raw))
        expect(response.status).to be_empty
      end
    end

    context 'when body is not JSON' do
      it 'throws JSON::ParserError' do
        raw = ''

        response = described_class.new(body: raw)

        expect { response.json! }.to raise_error(JSON::ParserError)
      end
    end
  end

  describe '#raw' do
    context 'when body is text' do
      it 'returns raw text' do
        raw = '<h1>Hi</h1>'

        response = described_class.new(body: raw)

        expect(response.raw).to eq(raw)
        expect(response.status).to be_empty
      end
    end
  end
end
