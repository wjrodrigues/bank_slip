# frozen_string_literal: true

module Bankslip
  class Record < ApplicationRecord
    self.table_name = 'bankslips'

    enum :status, %w[opened overdue canceled expired].index_by(&:itself), default: 'opened'
    enum :gateway, %w[kobana].index_by(&:itself), default: 'kobana'

    validates :bank, presence: true, allow_nil: true
    validates :external_id, presence: true, uniqueness: { case_sensitive: false }
    validates :barcode, presence: true, uniqueness: { case_sensitive: false }
    validates :expire_at, comparison: { greater_than: DateTime.now.end_of_day }
    validates :amount, comparison: { greater_than: 0 }

    belongs_to :customer, class_name: 'Customer::Record'
  end
end
