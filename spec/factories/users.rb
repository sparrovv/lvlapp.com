# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email 'sparrovv@gmail.com'
    password 'foobar12'
    password_confirmation 'foobar12'
  end
end
