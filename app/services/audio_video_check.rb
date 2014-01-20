class AudioVideoCheck
  class << self

    def disable_inactive
      before = AudioVideo.by_status(AudioVideo::ACTIVE).count

      AudioVideo.by_status(AudioVideo::ACTIVE).each do |video|
        next unless video.youtube?
        disable_if_inactive(video)
      end

      after = AudioVideo.by_status(AudioVideo::ACTIVE).count

      [before, after]
    end

    def disable_if_inactive(audio_video)
      video = YoutubeAudioVideoDecorator.new(audio_video)
      result = YoutubeVideo.get(video.youtube_id)

      if !result
        puts video.name
        video.status = AudioVideo::INACTIVE
        video.save
      end
    end

  end
end
