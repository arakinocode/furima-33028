FactoryBot.define do
  factory :buyer_address do
    post_code                { '111-1111' }
    prefecture_code_id       { 3 }
    city                     { '札幌市' }
    house_number             { '1-1' }
    building_name            { '建物' }
    phone_number             { '09012345678' }
    association :user
    association :item
    token { 'tok_bd6c9086615704f6f57fb61664eb' }
  end
end
