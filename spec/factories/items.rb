FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name }
    description { Faker::Books::Lovecraft.sentence }
    unit_price { Faker::Number.decimal }
  end
end
