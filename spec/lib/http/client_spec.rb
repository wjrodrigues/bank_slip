# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Http::Client do
  describe '#get' do
    context 'when the request was made successfully' do
      it 'calls client' do
        client = double('native')

        expect(client).to receive(:new).and_return(client)
        expect(client)
          .to receive(:get)
          .with(URI('http://any.com'), { header: {} })
          .and_return(Http::Lib::Response.new(body: '{}'))

        described_class.get('http://any.com', client:)
      end
    end
  end

  describe '#post' do
    context 'when the request was made successfully' do
      it 'calls client' do
        client = double('native')

        expect(client).to receive(:new).and_return(client)
        expect(client)
          .to receive(:post)
          .with(URI('http://any.com'), { header: {}, payload: {} })
          .and_return(Http::Lib::Response.new(body: '{}'))

        described_class.post('http://any.com', client:)
      end
    end
  end
end
