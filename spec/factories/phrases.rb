# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :phrase do
    name "ubiquitous"
    audio_video_id 1
    definition 'Present, appearing, or found everywhere: "his ubiquitous influence"'
    examples "Cowboy hats are ubiquitous among the male singers."
    translation "Wszechobecny"
  end
end
