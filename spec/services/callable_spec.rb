# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Callable do
  class MockCallable < Callable
    def call
      response
    end
  end

  describe '#call' do
    context 'when called' do
      it 'returns response' do
        response = MockCallable.call

        expect(response).to be_instance_of(ServiceResponse)
      end
    end
  end
end
