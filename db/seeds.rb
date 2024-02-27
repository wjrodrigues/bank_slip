# frozen_string_literal: true

if Rails.env.development?
  require_relative 'seeds/bankslips'
end
