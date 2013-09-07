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
end
