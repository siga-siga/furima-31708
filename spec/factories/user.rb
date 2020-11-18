FactoryBot.define do
  factory :user do
    nickname {Faker::Name.name}
    email {Faker::Internet.free_email}
    password {Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3, min_numeric: 3)}
    password_confirmation {password}
    last_name {Gimei.last.kanji}
    first_name {Gimei.first.kanji}
    last_name_kana {Gimei.last.katakana}
    first_name_kana {Gimei.first.katakana}
    birthday {Faker::Date.in_date_period}
  end
end