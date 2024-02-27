# frozen_string_literal: true

class BankslipsController < ApplicationController
  def index
    @bankslips = BankslipQuery.new(includes: [:customer]).all

    render :index
  end
end
