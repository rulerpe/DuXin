FactoryBot.define do
  factory :user do
    sequence(:phone_number) { |n| "123456789#{n}" }
    language { 'en' }
  end
end
