# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :audio_video do
    sequence :name do |n|
      "Video Title #{n}"
    end
    description "MyText"
    transcript '[{"time": "1.0", "text": "Hey you are all right"}]'
    url "MyString"
    duration 10.10
    status 'active'
    association :category, factory: :category
    association :level, factory: :level
  end
end
