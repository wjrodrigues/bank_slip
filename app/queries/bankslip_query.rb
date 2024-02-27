# frozen_string_literal: true

class BankslipQuery
  attr_accessor :bankslips, :columns
  private :bankslips=, :columns=

  def initialize(columns: '*', includes: nil, bankslips: Bankslip::Record.all)
    self.bankslips = bankslips.select(columns).order(created_at: :desc)
    self.bankslips = self.bankslips.includes(includes) unless includes.nil?
  end

  def all = bankslips

  def where(...) = bankslips.where(...)

  def find_by(...) = bankslips.find_by(...)
end
