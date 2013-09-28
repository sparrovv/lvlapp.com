require 'spec_helper'

describe YoutubeAudioVideoDecorator do
  let(:audio_video) { build(:audio_video) }

  describe 'youtube_id' do
    subject { YoutubeAudioVideoDecorator.new(audio_video)}
    it 'matches all combinations' do
      id = "-0bOH8ABpco"
      url = "http://www.youtube.com/watch?v=-0bOH8ABpco"
      subject.url = url
      subject.youtube_id.should == id

      url = "http://www.youtube.com/watch?v=-0bOH8ABpco&foo"
      subject.url = url
      subject.youtube_id.should == id

      url = "http://www.youtube.com/watch?v=-0bOH8ABpco#sadf"
      subject.url = url
      subject.youtube_id.should == id
    end
  end

end
