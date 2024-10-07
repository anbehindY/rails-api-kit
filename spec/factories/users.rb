FactoryBot.define do
  factory :user do
    email { "user@first.com" }
    password { "password" }
  end

  factory :invalid_user do
    name { "User99" }
    email { "user99mail" }
    password { "password" }
  end

  factory :valid_user do
    name { "User1" }
    email { "user1@mail.ocm" }
    password { "password" }
  end
end
