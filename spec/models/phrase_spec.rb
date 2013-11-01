require 'spec_helper'

describe Phrase do
  let(:phrase) { build(:phrase) }

  it 'has a valid factory' do
    expect(phrase).to be_valid
  end

  it 'validates name' do
    phrase.name = nil
    expect(phrase).to_not be_valid
  end

  it 'validates audio_video_id' do
    phrase.audio_video_id = nil
    expect(phrase).to_not be_valid
  end

  it 'belongs to audio_video' do
    audio_video = build(:audio_video)
    phrase.audio_video = audio_video
    phrase.audio_video.should == audio_video
  end

  context 'SM2 attributes' do
    it 'can have interval, easiness_factor and repetition_date' do
      phrase.interval = 1
      phrase.easiness_factor = '2.1'
      phrase.repetition_date = Date.tomorrow
      expect(phrase).to be_valid
      expect(phrase.easiness_factor).to eq 2.1
    end
  end

  it 'serializes fields' do
    arry = ['x']

    phrase.definition = arry
    phrase.examples = arry
    phrase.related = arry

    phrase.save and phrase.reload

    phrase.definition.should == arry
    phrase.examples.should == arry
    phrase.related.should == arry
  end

  describe '#sentence' do
    it 'has sentence' do
      phrase.sentence = "Improve your language skills by listening to your favourite songs."
      expect(phrase.sentence).to eq "Improve your language skills by listening to your favourite songs."
    end

    it 'trims it to 255 chars' do
      phrase.sentence = "i" * 300
      expect(phrase.sentence.size).to eq 255
    end
  end

  describe '#grouped_by_audio_video' do
    it 'returns hash of number of prases mapped to audio video' do
      phrase_1 = create(:phrase)
      phrase_2 = create(:phrase, user: phrase_1.user)
      phrase_3 = create(
        :phrase, audio_video: phrase_2.audio_video, user: phrase_1.user)
      phrase_4 = create(
        :phrase, audio_video: phrase_2.audio_video)

      expected = [
        Phrase::AudioVideoPhrase.new(2, 2, phrase_2.audio_video),
        Phrase::AudioVideoPhrase.new(1, 1, phrase_1.audio_video)
      ]

      result = Phrase.grouped_by_audio_video(phrase_1.user)

      expect(result.size).to eql expected.size
      expect(result[1]).to eql expected[0]
      expect(result[0]).to eql expected[1]
    end
  end
end
