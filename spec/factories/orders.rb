FactoryBot.define do
  factory :order do
    username { "MyString" }
    tel { 1 }
    address { "MyText" }
    user { nil }
  end
end
