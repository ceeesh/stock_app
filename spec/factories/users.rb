FactoryBot.define do
  factory :user do
    email { "dummy@email.com" }
    password { '12345678'}
    admin { false }
    email_verification { true }
    balance { 15000 }
  end
end
