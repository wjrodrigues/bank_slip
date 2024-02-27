# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankslipsController do
  describe '#index' do
    context 'when the request was made successfully' do
      it 'renders index with bankslips' do
        create_list(:bankslip_record, 2)

        get :index

        expect(assigns(:bankslips)).not_to be_nil
        expect(response).to render_template('index')
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#new' do
    context 'when the request was made successfully' do
      it 'renders new page' do
        get :new

        expect(response).to render_template('new')
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#create' do
    context 'when the request was made successfully' do
      it 'creates new bankslip and renders list' do
        params = attributes_for(:customer_record).merge(attributes_for(:bankslip_record))

        VCR.use_cassette('lib/gateway/providers/kobana_create') do
          post(:create, params:)
        end

        expect(Bankslip::Record.count).to eq(1)
        expect(subject.request.flash[:success]).to eq('Salvo com sucesso')
        expect(response).to redirect_to(new_bankslip_path)
      end
    end

    context 'when customer data are invalid' do
      it 'does not creates new bankslip' do
        post(:create, params: {})

        expect(Bankslip::Record.count).to be_zero
        expect(subject.request.flash[:success]).to be_nil
        expect(subject.request.flash[:error]).to eq('Dados do cliente inválidos')
        expect(response).to redirect_to(new_bankslip_path)
      end
    end

    context 'when bankslip are are invalid' do
      it 'does not creates new bankslip' do
        params = attributes_for(:customer_record).merge(attributes_for(:bankslip_record)).merge(amount: 0)

        post(:create, params:)

        expect(Bankslip::Record.count).to be_zero
        expect(subject.request.flash[:success]).to be_nil
        expect(subject.request.flash[:error]).to eq('Valor inválido')
        expect(response).to redirect_to(new_bankslip_path)
      end

      it 'does not creates new bankslip' do
        params = attributes_for(:customer_record).merge(attributes_for(:bankslip_record)).merge(expire_at: 1.day.ago)

        post(:create, params:)

        expect(Bankslip::Record.count).to be_zero
        expect(subject.request.flash[:success]).to be_nil
        expect(subject.request.flash[:error]).to eq('Data vencimento inválida')
        expect(response).to redirect_to(new_bankslip_path)
      end
    end
  end
end
