class PhrasesController < ApplicationController
  def index
    @phrases = Phrase.by_audio_video(params[:audio_video_id])
    render :json => @phrases
  end

  def create
    phrase = Phrase.new(phrase_params)
    if phrase.save
      render :json => phrase
    else
      render :json => phrase.errors, :status => 409
    end
  end

  private

  def phrase_params
    params.required(:phrase).permit(:name, :audio_video_id)
  end
end
