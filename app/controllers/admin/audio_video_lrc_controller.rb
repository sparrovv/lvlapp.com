class Admin::AudioVideoLrcController < ApplicationController
  def new
  end

  def create
    @lrc = LRCConverter.new.convert params[:content]
    render :show
  end

  def shift
    @audio_video_id = params[:audio_video_id]
    @time = params[:time]

    if @audio_video_id && @time
      audio_video = AudioVideo.find @audio_video_id
      lrc = LRCConverter.new
      @shifted_transcript = lrc.shift_time_by(audio_video.transcript_in_hash, BigDecimal(@time))
    end

    render :shift
  end
end
