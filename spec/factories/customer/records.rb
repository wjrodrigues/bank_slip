# frozen_string_literal: true

FactoryBot.define do
  factory :customer_record, class: 'Customer::Record' do
    name { Faker::Name.name }
    document { Faker::Number.number(digits: 11) }
    state { Faker::Address.state }
    city { Faker::Address.city }
    zipcode { Faker::Address.zip_code }
    address { Faker::Address.street_name }
    neighborhood { Faker::Address.community }

    trait :cnpj do
      document { Faker::Number.number(digits: 14) }
    end
  end
end
