class AudioVideosController < ApplicationController
  def index
    @audio_videos = AudioVideo.all
  end

  def show
    @audio_video = AudioVideo.find(params[:id])
  end
end
