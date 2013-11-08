require 'lrc_parser'

class Admin::AudioVideoLrcController < Admin::BaseController
  def new
  end

  def create
    @lrc = LRC::Parser.new(params[:content]).lvl_app_lines
    render :show
  end

  def shift
    @audio_video_id = params[:audio_video_id]
    @time = params[:time]

    if @audio_video_id && @time
      audio_video = AudioVideo.find @audio_video_id
      @shifted_transcript = TimeShifter.shift_by(audio_video.transcript_in_hash, BigDecimal(@time))
    end

    render :shift
  end
end
