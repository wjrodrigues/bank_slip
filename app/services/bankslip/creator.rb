# frozen_string_literal: true

module Bankslip
  class Creator < Callable
    attr_accessor :customer, :record, :status, :expire_at, :amount, :gateway, :external_id, :bank, :barcode

    ATTRS = %i[status expire_at amount gateway external_id bank barcode].freeze

    private :customer=, :record=, :status=, :expire_at=, :amount=, :gateway=, :external_id=, :bank=, :barcode=
    private_constant :ATTRS

    def initialize(params, customer:, record: Bankslip::Record)
      self.record = record
      self.customer = customer

      assign!(ATTRS, params)

      super(params, customer:, record:)
    end

    def call
      return response.add_error('already exists') if already_exists?

      bankslip = new_bankslip

      return response.add_error(bankslip.errors.messages) unless bankslip.valid?

      save!(bankslip)
    rescue StandardError => e
      Tracker::Track.notify(e)

      response.add_error('invalid data')
    end

    private

    def new_bankslip = record.new(customer:, status:, expire_at:, amount:, gateway:, external_id:, bank:, barcode:)

    def save!(bankslip)
      bankslip.save!

      response.add_result(bankslip)
    end

    def already_exists? = record.where(external_id:).or(record.where(barcode:)).exists?
  end
end
