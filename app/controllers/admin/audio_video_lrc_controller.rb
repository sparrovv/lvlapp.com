class Admin::AudioVideoLrcController < ApplicationController
  def new
  end

  def create
    @lrc = LRCConverter.new.convert params[:content]
    render :show
  end

  def shift
    audio_video = AudioVideo.find params[:audio_video_id]
    time = BigDecimal(params[:time])
    lrc = LRCConverter.new

    shifted_transcript = lrc.shift_time_by(audio_video.transcript_in_hash, time)

    render :text => shifted_transcript.to_json
  end
end
