FactoryBot.define do
  factory :orderitem do
    product { nil }
    quantity { 1 }
    order { nil }
  end
end
