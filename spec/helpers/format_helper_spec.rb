# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FormatHelper, :helper do
  class MockHelper
    include FormatHelper
  end

  describe '#to_real' do
    it { expect(MockHelper.new.to_real(10_000)).to eq('R$100,00') }
  end

  describe '#brl_date' do
    it 'returns date formatted to Brazil standard', :timecop do
      expect(MockHelper.new.brl_date(DateTime.now)).to eq('22/02/2023')
    end
  end
end
