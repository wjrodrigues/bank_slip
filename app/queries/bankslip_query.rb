# frozen_string_literal: true

class BankslipQuery
  attr_accessor :bankslips, :columns
  private :bankslips=, :columns=

  def initialize(columns: '*', bankslips: Bankslip::Record.all)
    self.bankslips = bankslips.select(columns).order(:expire_at)
  end

  def all = bankslips

  def where(...) = bankslips.where(...)

  def find_by(...) = bankslips.find_by(...)
end
