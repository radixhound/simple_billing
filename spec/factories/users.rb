# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "foo#{n}@bar.com" }
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      username 'admin'
      admin true
    end

    factory :pending_user do
      password ''
      password_confirmation ''

      before(:create) do |pending_user, evaluator|
        pending_user.create_signup_token
      end
    end
  end


end
