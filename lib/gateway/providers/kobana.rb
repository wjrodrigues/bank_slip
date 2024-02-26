# frozen_string_literal: true

module Gateway
  module Providers
    class Kobana
      attr_accessor :http_client
      private :http_client=

      URL = ->(uri) { "#{ENV.fetch('KOBANA_URL', nil)}/#{uri}" }

      def initialize(http_client: Http::Client)
        self.http_client = http_client
      end

      def create(params) = http_client.post(URL['bank_billets'], payload: payload(params), header:)
      def get(id) = http_client.post(URL["bank_billets/#{id}"], header:)

      private

      def token = ENV.fetch('KOBANA_TOKEN', nil)

      def header(extra = {})
        {
          accept: 'application/json',
          'content-type': 'application/json',
          authorization: "Bearer #{token}"
        }.merge(extra)
      end

      def payload(params)
        {
          expire_at: params['expire_at'],
          amount: Money.new(params['amount']).to_f
        }.merge(customer_payload(params))
      end

      def customer_payload(params)
        {
          customer_person_name: params['name'],
          customer_cnpj_cpf: params['document'],
          customer_state: params['state'],
          customer_city_name: params['city'],
          customer_zipcode: params['zipcode'],
          customer_address: params['address'],
          customer_neighborhood: params['neighborhood']
        }
      end
    end
  end
end
