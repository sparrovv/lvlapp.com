FactoryGirl.define do
  factory :category do
    sequence :name do |n|
      "Rock#{n}"
    end
    position 1
  end
end
