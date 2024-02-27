# frozen_string_literal: true

module Bankslip
  class CreatorProvider < Callable
    attr_accessor :provider, :expire_at, :amount, :name, :document, :state, :city, :zipcode, :address, :neighborhood

    ATTRS = %i[expire_at amount name document state city zipcode address neighborhood].freeze
    HTTP_STATUS_CREATED = 201
    private_constant :ATTRS, :HTTP_STATUS_CREATED

    def initialize(params, provider: Gateway::Provider)
      self.provider = provider

      assign!(ATTRS, params)

      super(params, provider:)
    end

    def call
      result = provider.create(attributes)

      return response.add_error('invalid data') if result.status.to_i != HTTP_STATUS_CREATED

      response.add_result(result.json!)
    rescue StandardError => e
      Tracker::Track.notify(e)

      response.add_error('invalid data')
    end

    private

    def attributes
      { expire_at:, amount:, name:, document:, state:, city:, zipcode:, address:, neighborhood: }
    end
  end
end
