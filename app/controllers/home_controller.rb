class HomeController < ApplicationController
  layout 'front'

  def index
    @recent_videos = AudioVideo.
      by_status(AudioVideo::ACTIVE).
      order('created_at desc').limit(8)

    @featured_videos = AudioVideo.
      featured.
      by_status(AudioVideo::ACTIVE).
      order('created_at desc').limit(8)
  end

end
