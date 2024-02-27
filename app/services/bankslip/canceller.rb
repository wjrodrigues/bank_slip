# frozen_string_literal: true

module Bankslip
  class Canceller < Callable
    attr_accessor :id, :record, :provider, :bankslip

    ATTRS = %i[id].freeze
    HTTP_STATUS = { success: 204, not_found: 404 }.freeze

    private_constant :ATTRS, :HTTP_STATUS

    def initialize(params, record: Bankslip::Record, provider: Gateway::Provider)
      self.provider = provider
      self.record = record

      assign!(ATTRS, params)

      super(params, provider:)
    end

    def call
      self.bankslip = record.find_by(id:)

      return response if invalid_bankslip?

      result = provider.cancel(bankslip.external_id)

      return response unless canceled?(result)

      success(result)
    rescue StandardError => e
      Tracker::Track.notify(e)

      response.add_error('bankslip.service.invalid_data', translate: true)
    end

    private

    def canceled?(result)
      status = result.response.status.to_i
      return true if status == HTTP_STATUS[:success]

      error = status == HTTP_STATUS[:not_found] ? 'bankslip.not_found' : 'bankslip.service.unavailable_provider'

      response.add_error(error, translate: true)

      false
    end

    def invalid_bankslip?
      return response.add_error('bankslip.not_found', translate: true) if bankslip.nil?

      response.add_error('bankslip.invalid_status', translate: true) if bankslip.canceled?
    end

    def success(result)
      bankslip.canceled!
      response.add_result({ provider: result.provider, body: result.response.json! })
    end
  end
end
