require 'delegate'

class YoutubeAudioVideoDecorator < SimpleDelegator

  def image_url
    if self.youtube?
      "http://img.youtube.com/vi/#{youtube_id}/0.jpg"
    elsif self.tedtalk?
      "ted-logo.jpg"
    else
      "http://placehold.it/210x166"
    end
  end

  def youtube_id
    url[/watch\?v=([^&#]+)?/, 1]
  end
end
