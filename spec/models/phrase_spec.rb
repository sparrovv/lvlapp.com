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

  describe '#singularize_phrase' do
    it 'singularizes name' do
      p = Phrase.new(name: 'kettles')
      p.singularize_phrase
      expect(p.name).to eql 'kettle'
      p.name = 'sashes'
      p.singularize_phrase
      expect(p.name).to eql 'sash'
      p.name = 'leaves'
      p.singularize_phrase
      expect(p.name).to eql 'leaf'
      p.name = 'knives'
      p.singularize_phrase
      expect(p.name).to eql 'knife'
    end
  end
end
