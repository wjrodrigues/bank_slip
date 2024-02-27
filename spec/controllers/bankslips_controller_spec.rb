# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BankslipsController do
  describe '#index' do
    context 'when the request was made successfully' do
      it 'renders index with bankslips' do
        create_list(:bankslip_record, 2)

        get :index

        expect(response).to render_template('index')
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
