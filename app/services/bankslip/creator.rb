# frozen_string_literal: true

module Bankslip
  class Creator < Callable
    attr_accessor :customer, :record, :provider, :expire_at, :amount, :gateway, :external_id, :bank, :barcode

    ATTRS = %i[expire_at amount].freeze

    private_constant :ATTRS

    def initialize(params, customer:, record: Bankslip::Record, provider: Bankslip::CreatorProvider)
      self.record = record
      self.customer = customer
      self.provider = provider

      assign!(ATTRS, params)

      format_data!

      super(params, customer:, record:)
    end

    def call
      return response if invalid_data?
      return error_msg('unavailable_provider') unless bankslip_provider!
      return error_msg('already_exists') if already_exists?

      bankslip = new_bankslip

      save!(bankslip)
    rescue StandardError => e
      Tracker::Track.notify(e)

      error_msg('invalid_data')
    end

    private

    def format_data!
      self.expire_at = Date.parse(expire_at) if expire_at.is_a?(String)
      self.amount = amount.gsub(Constants::WITHOUT_NUMBER, '').to_i if amount.is_a?(String)
    end

    def error_msg(key) = response.add_error("bankslip.service.#{key}", translate: true)

    def invalid_data?
      return error_msg('invalid_expire_at') if expire_at.nil? || expire_at.past?
      return error_msg('invalid_amount') if amount.zero? || amount.negative?
      return error_msg('invalid_customer') if customer.nil?

      false
    end

    def bankslip_provider!
      resp = provider.call(params_provider)

      return false unless resp.ok?

      self.barcode = resp.result.dig(:body, 'barcode')
      self.external_id = resp.result.dig(:body, 'id')
      self.gateway = resp.result[:provider]
    end

    def params_provider
      expire_at = self.expire_at.strftime('%d/%m/%Y')

      attrs_customer = customer.attributes.except(*%w[id deleted_at created_at updated_at])

      { expire_at:, amount: }.merge(attrs_customer)
    end

    def already_exists? = record.where(external_id:).or(record.where(barcode:)).exists?

    def new_bankslip = record.new(customer:, expire_at:, amount:, gateway:, external_id:, bank:, barcode:)

    def save!(bankslip)
      bankslip.save!

      response.add_result(bankslip)
    end
  end
end
