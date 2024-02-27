# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bankslip::Creator, :service do
  describe '#call' do
    context 'when all parameters are valid' do
      it 'creates bankslip' do
        customer = build(:customer_record)
        params = attributes_for(:bankslip_record).merge(amount: 'R$ 300,00')
        response = nil

        VCR.use_cassette('lib/gateway/providers/kobana_create') do
          response = described_class.call(params, customer:)
        end

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).to be_ok
        expect(response.result).to be_persisted
        expect(response.result.amount).to eq(30_000)
      end
    end

    context 'when all parameters are invalid' do
      it "returns error 'Data vencimento inválida'", :timecop do
        response = described_class.call({ expire_at: 1.day.ago }, customer: nil)

        expect(response).not_to be_ok
        expect(response.error).to eq('Data vencimento inválida')
      end

      it "returns error 'Valor inválido'" do
        response = described_class.call({ expire_at: Date.today, amount: 0 }, customer: nil)

        expect(response).not_to be_ok
        expect(response.error).to eq('Valor inválido')
      end

      it "returns error 'Dados do cliente inválidos'" do
        response = described_class.call({ expire_at: Date.today, amount: 1000 }, customer: nil)

        expect(response).not_to be_ok
        expect(response.error).to eq('Dados do cliente inválidos')
      end
    end

    context 'when bankslip exists' do
      it 'does not create new' do
        provider = double('Bankslip::CreatorProvider')
        bankslip = create(:bankslip_record)
        result = Struct.new(:result, :ok?).new(
          ok?: true,
          result: { body: { 'barcode' => bankslip.barcode, 'id' => bankslip.external_id }, provider: :kobana }
        )

        expect(provider).to receive(:call).and_return(result)
        expect_any_instance_of(Bankslip::Record).not_to receive(:save!)

        response = described_class.call(bankslip, customer: bankslip.customer, provider:)

        expect(response).not_to be_ok
        expect(response.error).to eq('Já cadastrado')
      end
    end

    context 'when provider unavailable' do
      it 'does not create new' do
        bankslip = build(:bankslip_record)
        provider = double('Bankslip::CreatorProvider')

        result = Struct.new(:ok?).new(ok?: false)

        expect(provider).to receive(:call).and_return(result)
        expect_any_instance_of(Bankslip::Record).not_to receive(:save!)

        response = described_class.call(bankslip, customer: bankslip.customer, provider:)

        expect(response).not_to be_ok
        expect(response.error).to eq('Provedor indisponível')
      end
    end

    context 'when raise error' do
      it 'calls Tracker::Track#notify' do
        bankslip = build(:bankslip_record)

        expect(bankslip.expire_at).to receive(:nil?).and_raise(StandardError)
        expect(Tracker::Track).to receive(:notify).with(StandardError)

        response = described_class.call(bankslip, customer: bankslip.customer)

        expect(response).not_to be_ok
        expect(response.error).to eq('Dados inválidos')
      end
    end
  end
end
