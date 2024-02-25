# frozen_string_literal: true

module Bankslip
  class Record < ApplicationRecord
    self.table_name = 'bankslips'

    enum :status, %w[opened overdue canceled expired].index_by(&:itself), default: 'opened'
    enum :gateway, %w[kobana].index_by(&:itself), default: 'kobana'

    validates :expire_at, comparison: { greater_than: DateTime.current }
    validates :amount, comparison: { greater_than: 0 }

    belongs_to :customer, class_name: 'Customer::Record'
  end
end