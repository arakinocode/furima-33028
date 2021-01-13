FactoryBot.define do
  factory :item do
    name                { Faker::Name.initials(number: 6) }
    introduction        { '商品の説明' }
    category_id         { 3 }
    item_condition_id   { 3 }
    postage_type_id     { 3 }
    preparation_day_id  { 3 }
    prefecture_code_id  { 3 }
    price               { 500 }

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
