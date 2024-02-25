# frozen_string_literal: true

module Customer
  class Creator < Callable
    attr_accessor :record, :name, :document, :state, :city, :zipcode, :address, :neighborhood

    ATTRS = %i[name document state city zipcode address neighborhood].freeze

    private :name=, :document=, :state=, :city=, :zipcode=, :address=, :neighborhood=
    private_constant :ATTRS

    def initialize(params, record: Customer::Record)
      self.record = record

      assign!(ATTRS, params)

      super(params, record:)
    end

    def call
      if (customer = record.find_by(document:))
        return response.add_result(customer)
      end

      customer = new_customer

      return response.add_error(customer.errors.messages) unless customer.valid?

      save!(customer)
    rescue StandardError => e
      binding.irb
    end

    private

    def new_customer = record.new(name:, document:, state:, city:, zipcode:, address:, neighborhood:)

    def save!(customer)
      customer.save!

      response.add_result(customer)
    end
  end
end
