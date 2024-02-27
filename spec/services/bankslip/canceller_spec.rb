# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bankslip::Canceller, :service do
  describe '#call' do
    context 'when the bankslip does not exist' do
      it 'does not cancel bankslip' do
        provider = double('Gateway::Provider')

        expect(provider).not_to receive(:cancel)

        response = described_class.call({ id: '123' })

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).not_to be_ok
        expect(response.error).to eq('Registro não encontrado')
      end

      it 'does not cancel bankslip' do
        bankslip = create(:bankslip_record)
        provider = double('Gateway::Provider')

        payload = Struct.new(:status).new(status: '404')
        result = Struct.new(:provider, :response).new(provider: :kobana, response: payload)

        expect(provider).to receive(:cancel).and_return(result)

        response = described_class.call({ id: bankslip.id }, provider:)

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).not_to be_ok
        expect(response.error).to eq('Registro não encontrado')
      end
    end

    context 'when the bankslip has already been canceled' do
      it 'does not cancel bankslip' do
        bankslip = create(:bankslip_record, :canceled)
        provider = double('Gateway::Provider')

        expect(provider).not_to receive(:cancel)

        response = described_class.call({ id: bankslip.id })

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).not_to be_ok
        expect(response.error).to eq('Status inválido')
      end
    end

    context 'when the provider is unavailable' do
      it 'does not cancel bankslip' do
        bankslip = create(:bankslip_record)
        provider = double('Gateway::Provider')

        payload = Struct.new(:status).new(status: '500')
        result = Struct.new(:provider, :response).new(provider: :kobana, response: payload)

        expect(provider).to receive(:cancel).and_return(result)

        response = described_class.call({ id: bankslip.id }, provider:)

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).not_to be_ok
        expect(response.error).to eq('Provedor indisponível')
      end
    end

    context 'when the bankslip is valid' do
      it 'cancels bankslip' do
        bankslip = create(:bankslip_record)
        provider = double('Gateway::Provider')

        payload = Struct.new(:status, :json!).new(status: '204', json!: JSON.parse('{"name":"any"}'))
        result = Struct.new(:provider, :response).new(provider: :kobana, response: payload)

        expect(provider).to receive(:cancel).and_return(result)

        response = described_class.call({ id: bankslip.id }, provider:)

        expect(bankslip.reload).to be_canceled
        expect(response).to be_instance_of(ServiceResponse)
        expect(response).to be_ok
        expect(response.error).to be_nil
      end
    end

    context 'when raise error' do
      it 'calls Tracker::Track#notify' do
        record = double('Bankslip::Record')
        params = { id: 1 }

        expect(record).to receive(:find_by).with(params).and_raise(StandardError)
        expect(Tracker::Track).to receive(:notify).with(StandardError)

        response = described_class.call(params, record:)

        expect(response).not_to be_ok
        expect(response.error).to eq('Dados inválidos')
      end
    end
  end
end
