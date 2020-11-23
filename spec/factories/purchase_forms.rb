FactoryBot.define do
  factory :purchase_form do
    postal_code   { '123-4567' }
    prefecture_id { 2 }
    city          { '横浜市緑区' }
    block         { '青山1-1-1' }
    phone         { Faker::Number.leading_zero_number(digits: 11) }
    user_id       { 1 }
    item_id       { 1 }
    token         {"tok_abcdefghijk00000000000000000"}
  end
end
