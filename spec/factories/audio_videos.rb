# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :audio_video do
    name "MyString"
    description "MyText"
    transcript "{'foo': 'bar'}"
    url "MyString"
    duration 10.10
    status 'active'
    association :category, factory: :category
    association :level, factory: :level
  end
end
