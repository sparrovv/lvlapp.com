# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_datum do
    association :audio_video, factory: :audio_video
    association :user, factory: :user, strategy: :build
    blanks 1
    guessed 1
    skipped 1
    mistakes 1
    time 1
    level "medium"
  end
end
