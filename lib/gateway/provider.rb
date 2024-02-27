# frozen_string_literal: true

module Gateway
  class Provider
    PROVIDERS = {
      kobana: Gateway::Providers::Kobana
    }.freeze

    private_constant :PROVIDERS
    private_class_method :new

    Response = ->(provider, response) { Struct.new(:provider, :response).new(provider:, response:) }

    private_constant :Response

    def self.get(id, provider: :kobana) = Response.call(provider, new.provider!(provider).get(id))

    def self.create(params, provider: :kobana) = Response.call(provider, new.provider!(provider).create(params))

    def self.cancel(id, provider: :kobana) = Response.call(provider, new.provider!(provider).cancel(id))

    def provider!(provider) = PROVIDERS[provider.to_sym].new
  end
end
