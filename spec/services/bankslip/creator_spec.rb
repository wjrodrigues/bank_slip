# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bankslip::Creator, :service do
  describe '#call' do
    context 'when all parameters are valid' do
      it 'creates bankslip' do
        customer = build(:customer_record)
        response = described_class.call(attributes_for(:bankslip_record), customer:)

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).to be_ok
        expect(response.result).to be_persisted
      end
    end

    context 'when all parameters are invalid' do
      it 'returns errors', locale: :en do
        response = described_class.call({}, customer: nil)

        expected = {
          amount: ["can't be blank"],
          barcode: ["can't be blank"],
          customer: ['must exist'],
          expire_at: ["can't be blank"],
          external_id: ["can't be blank"]
        }

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).not_to be_ok
        expect(response.error).to eq(expected)
      end
    end

    context 'when bankslip exists' do
      it 'does not create new' do
        bankslip = create(:bankslip_record)

        expect_any_instance_of(Bankslip::Record).not_to receive(:save!)

        response = described_class.call(bankslip, customer: bankslip.customer)

        expect(response).not_to be_ok
        expect(response.error).to eq('already exists')
      end
    end

    context 'when raise error' do
      it 'calls Tracker::Track#notify' do
        customer = build(:customer_record)
        record = double('Bankslip::Record')

        expect(record).to receive(:where).and_raise(StandardError)
        expect(Tracker::Track).to receive(:notify).with(StandardError)

        response = described_class.call(attributes_for(:bankslip_record), customer:, record:)

        expect(response).not_to be_ok
        expect(response.error).to eq('invalid data')
      end
    end
  end
end
