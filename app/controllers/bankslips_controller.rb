# frozen_string_literal: true

class BankslipsController < ApplicationController
  def index
    @bankslips = BankslipQuery.new(includes: [:customer]).all

    render :index
  end

  def new
    render :new
  end

  def create
    values = params.permit(*permit_keys)

    customer = Customer::Creator.call(values)

    return flash_and_redirect!(t('bankslip.form.invalid_customer'), :error) unless customer.ok?

    bankslip = Bankslip::Creator.call(values, customer: customer.result)

    return flash_and_redirect!(bankslip.error, :error) unless bankslip.ok?

    flash_and_redirect!(I18n.t('bankslip.form.success_save'), :success)
  end

  def destroy
    page = bankslip_path
    result = Bankslip::Canceller.call({ id: params[:id] })

    return flash_and_redirect!(result.error, :error, page) unless result.ok?

    flash_and_redirect!(I18n.t('bankslip.form.success_cancel'), :success, page)
  end

  private

  def flash_and_redirect!(msg, key, page = new_bankslip_path)
    flash[key] = msg
    redirect_to page
  end

  def flash_error!(msg) = flash[:error] = msg

  def permit_keys = %i[amount expire_at document name zipcode city state neighborhood address]
end
