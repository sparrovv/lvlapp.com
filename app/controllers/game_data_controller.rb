class GameDataController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_audio_video, only: :create

  def index
    @game_data = current_user.game_data.includes(:audio_video).order(:created_at)
    @game_data = current_user.
      game_data.includes(:audio_video).order('created_at desc')
  end

  def create
    game_datum = GameDatum.new(game_datum_params).tap do |game_datum|
      game_datum.audio_video = @audio_video
      game_datum.user = current_user
    end

    if game_datum.save
      render :json => game_datum
    else
      render :json => game_datum.errors, :status => 409
    end
  end

  private
  def load_audio_video
    @audio_video = AudioVideo.find params[:audio_video_id]
  end

  def audio_video_id
    params.required(:audio_video_id)
  end

  def game_datum_params
    params.required(:game_datum).
      permit(:total_points, :blanks, :guessed, :skipped, :mistakes, :time, :level,
             {:summary => [:time_bonus, :guessed_points]})
  end

end
