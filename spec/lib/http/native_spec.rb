# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'HTTP::Native' do
  describe '#get' do
    context 'when the request was made successfully' do
      it 'returns json structure' do
        VCR.use_cassette('lib/http/native') do
          url = URI('https://viacep.com.br/ws/01001000/json/')

          native = Http::Native.new
          response = native.get(url)

          expect(response).to be_instance_of(Http::Response)
        end
      end
    end
  end
end
