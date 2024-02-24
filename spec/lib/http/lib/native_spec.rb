# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Http::Lib::Native do
  describe '#get' do
    context 'when the request was made successfully' do
      it 'returns json structure' do
        VCR.use_cassette('lib/http/native_get') do
          url = URI('https://viacep.com.br/ws/01001000/json/')

          native = described_class.new
          response = native.get(url)

          expect(response).to be_instance_of(Http::Lib::Response)
          expect(response.status).to eq('200')
        end
      end
    end
  end

  describe '#post' do
    context 'when the request was made successfully' do
      it 'returns json structure' do
        VCR.use_cassette('lib/http/native_post') do
          url = URI('https://httpbin.org/anything')

          native = described_class.new
          response = native.post(url)

          expect(response).to be_instance_of(Http::Lib::Response)
          expect(response.status).to eq('200')
        end
      end
    end
  end
end
