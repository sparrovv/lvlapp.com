require 'spec_helper'

describe AudioVideo do
  let(:audio_video) { build(:audio_video) }

  it 'has valid factory' do
    expect(audio_video).to be_valid
  end

  describe '#status' do
    it 'initializes with pending status' do
      av = AudioVideo.new
      av.status.should == AudioVideo::PENDING
    end

    it 'requires status' do
      audio_video.status = nil
      expect(audio_video).to_not be_valid
      expect(audio_video.errors).to include(:status)
    end

    it 'can be pending or active' do
      audio_video.status = 'pending'
      expect(audio_video).to be_valid

      audio_video.status = 'active'
      expect(audio_video).to be_valid

      audio_video.status = 'notsuchstatus'
      expect(audio_video).to_not be_valid
    end
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

  it 'valdates level presence' do
    level = build(:level)

    audio_video.level = nil
    audio_video.valid?.should be_false
    audio_video.level = level

    audio_video.valid?.should be_true
  end

  describe '#level_name' do
    it 'returns level name' do
      level = build(:level, name: 'foo')
      audio_video.level = level
      expect(audio_video.level_name).to eql 'foo'
    end
  end
end
