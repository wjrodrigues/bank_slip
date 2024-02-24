# frozen_string_literal: true

module Customer
  class Record < ApplicationRecord
    self.table_name = 'customers'

    validates :name, :document, :state, :city, :zipcode, :address, :neighborhood, presence: true
    validate :document_valid?

    private

    def document_valid?
      errors.add(:document, 'invalid document') unless document&.size == 11 || document&.size == 14
    end
  end
end
