class AudioVideosController < ApplicationController
  def index
    @audio_videos = AudioVideo.order('created_at desc')
  end

  def show
    @audio_video = AudioVideo.find(params[:id])
  end
end
