class AudioVideoDisabling
  class << self

    def run
      before = AudioVideo.by_status(AudioVideo::ACTIVE).count

      AudioVideo.by_status(AudioVideo::ACTIVE).each do |video|
        next unless video.youtube?
        video_check(video)
      end

      after = AudioVideo.by_status(AudioVideo::ACTIVE).count

      [before, after]
    end

    def video_check(audio_video)
      video = YoutubeAudioVideoDecorator.new(audio_video)
      result = YoutubeVideo.get(video.youtube_id)

      if !result
        puts video.name
        puts 'video not found in youtube'
        video.status = AudioVideo::INACTIVE
        video.save
        puts 'status changed'
      end
    end

  end
end
