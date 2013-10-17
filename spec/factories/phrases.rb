# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phrase do
    name "ubiquitous"
    association :audio_video, factory: :audio_video
    association :user, factory: :user, strategy: :build
    definition 'Present, appearing, or found everywhere: "his ubiquitous influence"'
    examples "Cowboy hats are ubiquitous among the male singers."
    sentence "Cowboy hats are ubiquitous among the male singers."
    translation "Wszechobecny"
  end
end
