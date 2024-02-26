# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gateway::Providers::Kobana do
  describe '#create' do
    context 'when the request was made successfully' do
      it 'calls client' do
        customer = attributes_for(:customer_record, zipcode: '57081816', state: 'AL', document: '81361459034')
        params = attributes_for(:bankslip_record).merge(customer)
        response = nil
        provider = described_class.new

        VCR.use_cassette('lib/gateway/providers/kobana_create') do
          response = provider.create(params.as_json)
        end

        json = response.json!

        expect(response.status).to eq('201')
        expect(json['id']).to eq(632_217)
        expect(json['amount']).to eq(300.0)
        expect(json['expire_at']).to eq('2024-02-29')
        expect(json['barcode']).to eq('00191964100000300000000009999999000000000317')
      end
    end
  end
end
