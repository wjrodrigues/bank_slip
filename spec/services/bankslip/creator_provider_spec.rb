# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bankslip::CreatorProvider, :service do
  describe '#call' do
    let(:params) do
      attributes_for(:customer_record)
        .merge(attributes_for(:bankslip_record))
        .slice(:expire_at, :amount, :name, :document, :state, :city, :zipcode, :address, :neighborhood)
    end

    let(:provider) { double('Gateway::Provider') }

    context 'when provider is successfully' do
      it 'calls provider and create' do
        payload = Struct.new(:status, :json!).new(status: '201', json!: JSON.parse('{"name":"any"}'))
        result = Struct.new(:provider, :response).new(provider: :kobana, response: payload)

        expect(provider).to receive(:create).with(params).and_return(result)

        response = described_class.call(params, provider:)

        expect(response).to be_ok
        expect(response.result).to eq({ provider: :kobana, body: { 'name' => 'any' } })
      end
    end

    context 'when the provider is unsuccessful' do
      it 'returns errors' do
        result = Struct.new(:status).new(status: '404')

        expect(provider).to receive(:create).with(params).and_return(result)

        response = described_class.call(params, provider:)

        expect(response).not_to be_ok
        expect(response.error).to eq('invalid data')
      end
    end

    context 'when raise error' do
      it 'calls Tracker::Track#notify' do
        expect(provider).to receive(:create).and_raise(StandardError)
        expect(Tracker::Track).to receive(:notify).with(StandardError)

        response = described_class.call(params, provider:)

        expect(response).not_to be_ok
        expect(response.error).to eq('invalid data')
      end
    end
  end
end
