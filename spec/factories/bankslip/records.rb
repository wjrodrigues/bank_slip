# frozen_string_literal: true

FactoryBot.define do
  factory :bankslip_record, class: 'Bankslip::Record' do
    customer

    status { 'opened' }
    gateway { kobana }
    expire_at { 3.days.from_now }
    amount { 30_000 }

    trait :overdue do
      status { 'overdue' }
      expire_at { 3.hours.ago }
    end

    trait :canceled do
      status { 'canceled' }
    end

    trait :expired do
      status { 'expired' }
    end
  end
end
