# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :level do
    sequence :name do |n|
      "easy#{n}"
    end
  end
end
