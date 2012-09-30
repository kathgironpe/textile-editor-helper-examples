require 'faker'

FactoryGirl.define do
  factory :user do
    email  { Faker::Internet.email }
    username { Faker::Internet.user_name }
    crypted_password { Sorcery::CryptoProviders::BCrypt.encrypt("secret", salt) }
    salt 'asdasdastr4325234324sdfds'
  end
end
