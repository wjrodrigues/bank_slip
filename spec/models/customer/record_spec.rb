# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer::Record, :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:neighborhood) }

    context 'when the document size must be valid' do
      it 'returns errors if CPF invalid' do
        %w[000000000000 0000000000].each do |document|
          customer = build(:customer_record, document:)

          expect(customer).not_to be_valid
          expect(customer.errors.messages).to eq(document: ['invalid document'])
        end
      end

      it 'returns errors if CNPJ invalid' do
        %w[000000000000000 0000000000000].each do |document|
          customer = build(:customer_record, document:)

          expect(customer).not_to be_valid
          expect(customer.errors.messages).to eq(document: ['invalid document'])
        end
      end

      it 'returns true if documents valid' do
        %w[00000000000000 00000000000].each do |document|
          customer = build(:customer_record, document:)

          expect(customer).to be_valid
          expect(customer.errors.messages).to be_empty
        end
      end
    end
  end
end
