# frozen_string_literal: true

module FormatHelper
  def to_real(value) = Money.new(value).format

  def brl_date(date) = date.strftime('%d/%m/%Y')
end
