# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer::Creator, :service do
  describe '#call' do
    context 'when all parameters are valid' do
      it 'creates customer' do
        response = described_class.call(attributes_for(:customer_record))

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).to be_ok
        expect(response.result).to be_persisted
      end
    end

    context 'when all parameters are invalid' do
      it 'returns errors' do
        response = described_class.call({})

        expected = {
          name: ["can't be blank"],
          document: ["can't be blank", 'invalid document'],
          state: ["can't be blank"],
          city: ["can't be blank"],
          zipcode: ["can't be blank"],
          address: ["can't be blank"],
          neighborhood: ["can't be blank"]
        }

        expect(response).to be_instance_of(ServiceResponse)
        expect(response).not_to be_ok
        expect(response.error).to eq(expected)
      end
    end

    context 'when customer exists' do
      it 'does not create new' do
        customer = create(:customer_record)

        expect_any_instance_of(Customer::Record).not_to receive(:save!)

        response = described_class.call(customer)

        expect(response).to be_ok
        expect(response.result).to eq(customer)
      end
    end

    context 'when raise error' do
      it 'calls Tracker::Track#notify' do
        record = double('Customer::Record')

        expect(record).to receive(:find_by).and_raise(StandardError)
        expect(Tracker::Track).to receive(:notify).with(StandardError)

        response = described_class.call(attributes_for(:customer_record), record:)

        expect(response).not_to be_ok
        expect(response.error).to eq('invalid data')
      end
    end
  end
end
