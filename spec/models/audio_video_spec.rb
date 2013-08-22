require 'spec_helper'

describe AudioVideo do
  let(:audio_video) { build(:audio_video) }

  it 'has valid factory' do
    expect(audio_video).to be_valid
  end

  it do
    audio_video.name = nil
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:name)
  end

  it do
    audio_video.transcript = nil
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:transcript)
  end

  it do
    audio_video.url = nil
    expect(audio_video).to_not be_valid
    expect(audio_video.errors).to include(:url)
  end
end
