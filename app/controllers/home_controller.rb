class HomeController < ApplicationController
  layout 'front'

  def index
    @recent_videos = AudioVideo.
      by_status(AudioVideo::ACTIVE).
      order('created_at desc').limit(12)

    @popular_videos = AudioVideo.
      by_status(AudioVideo::ACTIVE).
      order('views_count desc').limit(12)

    @featured_videos = AudioVideo.
      featured.
      by_status(AudioVideo::ACTIVE).
      order('created_at desc').limit(12)
  end

end
