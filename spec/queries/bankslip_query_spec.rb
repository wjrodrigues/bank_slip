# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankslipQuery, :queries do
  describe '#all' do
    context 'when exists records' do
      it 'returns records' do
        bankslips = create_list(:bankslip_record, 2)

        expect(described_class.new.all).to eq(bankslips)
        expect(Bankslip::Record.count).to eq(2)
      end
    end
  end

  describe '#where' do
    context 'when filter record' do
      it 'returns records' do
        bankslips = create_list(:bankslip_record, 2)
        expected = bankslips.last

        response = described_class.new.where({ id: expected.id })

        expect(response).to eq([expected])
      end
    end
  end

  describe '#find_by' do
    context 'when filter record' do
      it 'returns records' do
        bankslips = create_list(:bankslip_record, 2)
        expected = bankslips.last

        response = described_class.new.find_by({ id: expected.id })

        expect(response).to eq(expected)
      end
    end
  end
end
