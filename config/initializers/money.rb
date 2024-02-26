# frozen_string_literal: true

require 'money'

Money.locale_backend = :i18n
Money.default_currency = Money::Currency.new("BRL")
