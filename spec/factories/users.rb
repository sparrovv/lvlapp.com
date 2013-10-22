# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end

    native_language 'pl'
    password 'foobar12'
    password_confirmation 'foobar12'
  end
end
