require 'spec_helper'

describe User do
  let(:user) { build(:user) }
  it 'has valid factory' do
    user.should be_valid
  end

  it 'has many phrases' do
    phrase_1 = build(:phrase)
    user.phrases << phrase_1
    user.save
    user.phrases.should include phrase_1
  end

  it 'can get phrases by audio_video id' do
    audio_video_1 = create(:audio_video)
    audio_video_2 = create(:audio_video)
    phrase_1 = create(:phrase, :audio_video => audio_video_1)
    phrase_2 = create(:phrase, :audio_video => audio_video_2)

    user.phrases << phrase_1
    user.save

    phrases = user.phrases_by_audio_video(audio_video_1)

    phrases.size.should eq 1
    phrases.should include phrase_1
  end
  it 'has stats by audio video'
end
