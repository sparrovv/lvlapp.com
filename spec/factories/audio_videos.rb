# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :audio_video do
    name "MyString"
    description "MyText"
    transcript "{'foo': 'bar'}"
    url "MyString"
    length 1
  end
end
