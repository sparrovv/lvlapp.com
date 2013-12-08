require 'spec_helper'

describe User do
  let(:user) { build(:user) }

  it 'has valid factory' do
    user.should be_valid
  end

  it 'validates native language presence' do
    user.native_language = nil
    expect(user).to_not be_valid
  end

  it 'has admin flag false by default' do
    user = User.new
    expect(user.admin?).to be_false

    user.admin = true
    expect(user.admin?).to be_true
  end

  it 'has many phrases' do
    phrase_1 = build(:phrase)
    user.phrases << phrase_1
    user.save
    user.phrases.should include phrase_1
  end

  it 'can get phrases by audio_video id' do
    user.save
    audio_video_1 = create(:audio_video)
    audio_video_2 = create(:audio_video)
    phrase_1 = create(:phrase, :audio_video => audio_video_1, user: user)
    phrase_2 = create(:phrase, :audio_video => audio_video_2)

    phrases = user.phrases_by_audio_video(audio_video_1)

    phrases.size.should eq 1
    phrases.should include phrase_1
  end

  describe '#points' do
    it 'returns number of total points from game data for given user' do
      user.save!
      create(:game_datum, user: user, total_points: 20)
      create(:game_datum, user: user, total_points: 45)
      user_2 = create(:user)
      create(:game_datum, user: user_2, total_points: 20)

      expect(user.points).to eql 65
    end
  end

  describe '#username' do
    it 'returns first part of email - name' do
      user.email = "foobar@foo.com"

      expect(user.username).to eql 'foobar'
    end
  end
end
