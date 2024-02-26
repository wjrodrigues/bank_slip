# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gateway::Provider do
  describe '#create' do
    context 'when the request was made successfully' do
      it 'calls provider' do
        params = attributes_for(:bankslip_record).merge(attributes_for(:customer_record))

        expect_any_instance_of(Gateway::Providers::Kobana).to receive(:create).with(params)

        described_class.create(params)
      end
    end
  end

  describe '#get' do
    context 'when the request was made successfully' do
      it 'calls provider' do
        id = 1

        expect_any_instance_of(Gateway::Providers::Kobana).to receive(:get).with(id)

        described_class.get(id)
      end
    end
  end

  describe '#cancel' do
    context 'when the request was made successfully' do
      it 'calls provider' do
        id = 1

        expect_any_instance_of(Gateway::Providers::Kobana).to receive(:cancel).with(id)

        described_class.cancel(id)
      end
    end
  end
end
