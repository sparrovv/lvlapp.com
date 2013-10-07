class ViewCounter

  def increment(audio_video, storage)
    key = :"audio_video_#{audio_video.id}_viewed"
    return if storage[key]

    AudioVideo.increment_counter(:views_count, audio_video.id)
    audio_video.reload
    storage[key] = '1'
  end

end
