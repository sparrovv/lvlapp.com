require 'spec_helper'

describe AudioVideo do
  let(:audio_video) { build(:audio_video) }

  it 'has valid factory' do
    expect(audio_video).to be_valid
  end

  it 'validates name' do
    audio_video.name = nil
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:name)
  end

  it 'validates transcript' do
    audio_video.transcript = nil
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:transcript)
  end

  it 'validates url' do
    audio_video.url = nil
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:url)
  end


  describe '#category' do
    it 'validates category' do
      category = build(:category)

      audio_video.category = nil
      audio_video.valid?.should be_false
      audio_video.category = category

      audio_video.valid?.should be_true
    end
  end
end
