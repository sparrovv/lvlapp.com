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

  it 'generates slug before validation' do
    audio_video.name = 'foo bar'
    audio_video.valid?
    expect(audio_video.slug).to eq 'foo-bar'
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

  it 'validates transcript that it is valid json' do
    audio_video.transcript = '[{"text":"foo bar" i}]'
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:transcript)
  end

  it 'validates that there is space after comma' do
    audio_video.transcript = '[{"text":"hey yola, go and foo,bar"}]'
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:transcript)
  end

  it 'validates that there is space after comma' do
    audio_video.transcript = '[{"text":"Nice to meet your foo.bar"}]'
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:transcript)
  end

  it 'validates url' do
    audio_video.url = nil
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:url)
  end

  describe 'duration' do
    it 'converts from string' do
      audio_video.duration = '12.33333'
      audio_video.save
      audio_video.reload
      expect(audio_video.duration).to eq BigDecimal.new('12.33')
    end
  end

  describe '#featured' do
    let!(:audio_video_1) { create(:audio_video, featured: true)}
    let!(:audio_video_2) { create(:audio_video, featured: false)}

    it 'loads featured videos' do
      expect(AudioVideo.featured.size).to be 1
      expect(AudioVideo.featured).to include audio_video_1
    end
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

  describe 'scopes' do
    describe '.popular' do
      before do
        @av_1 = create(:audio_video, views_count: 4)
        @av_2 = create(:audio_video, views_count: 6)
        @av_3 = create(:audio_video, views_count: 1)
        @av_4 = create(:audio_video, views_count: 0)
      end

      it 'returns in ordered by views_count' do
        audio_videos = AudioVideo.popular
        expect(audio_videos.size).to be 3
        expect(audio_videos[0]).to eq @av_2
        expect(audio_videos[1]).to eq @av_1
        expect(audio_videos[2]).to eq @av_3
      end
    end
  end
end
