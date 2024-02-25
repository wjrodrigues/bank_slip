# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bankslip::Record, :model do
  describe 'validations' do
    it {
      should define_enum_for(:status)
        .with_values({ opened: 'opened', overdue: 'overdue', canceled: 'canceled', expired: 'expired' })
        .backed_by_column_of_type(:string)
    }

    it { should belong_to(:customer).class_name('Customer::Record') }
    it { should define_enum_for(:gateway).with_values({ kobana: 'kobana' }).backed_by_column_of_type(:string) }
    it { should validate_comparison_of(:amount).is_greater_than(0) }
    it { should validate_comparison_of(:expire_at).is_greater_than(DateTime.now.end_of_day) }
  end
end
