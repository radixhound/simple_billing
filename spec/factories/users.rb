# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    username 'garbles'
    email 'foo@bar.com'
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      admin true
    end
  end


end
