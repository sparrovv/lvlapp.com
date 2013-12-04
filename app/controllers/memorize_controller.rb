class MemorizeController < ApplicationController
  before_filter :authenticate_user!

  def show
    @phrases = Phrase.
      by_user(current_user).
      by_audio_video(params[:audio_video_id])
  end

  def random
    limit = params[:limit] || 10

    @phrases = Phrase.
      order(:repetition_date).
      limit(limit)

    render :show
  end

  def index
    @number_of_phrases = Phrase.by_user(current_user).count
    @audio_video_phrases = Phrase.grouped_by_audio_video(current_user)
  end

  def create
  end

  def update
  end
end
