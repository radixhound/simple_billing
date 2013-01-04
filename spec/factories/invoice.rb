# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
    title 'title'
    description 'hello'
    paid false
    amount 5.00
    date Time.current
    user
  end

end