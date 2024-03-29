# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Callable do
  class MockCallable < Callable
    attr_accessor :name
    private :name=

    def initialize(params = {})
      super(params)

      assign!(%i[name], params)
    end

    def call = response.add_result(name:)
  end

  describe '#call' do
    context 'when called' do
      it 'returns response' do
        response = MockCallable.call({ 'name' => 'pedro' })

        expect(response).to be_instance_of(ServiceResponse)
        expect(response.result).to eq({ name: 'pedro' })
      end

      it 'returns response with attr' do
        expected = { name: Faker::Name.name }
        response = MockCallable.call(expected)

        expect(response.result).to eq(expected)
        expect(response).to be_instance_of(ServiceResponse)
      end
    end
  end
end
