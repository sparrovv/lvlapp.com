class PhrasesController < ApplicationController
  def index
    @phrases = Phrase.by_audio_video(params[:audio_video_id])
    render :json => @phrases
  end

  def create
    audio_video = AudioVideo.find(audio_video_id)
    phrase = Phrase.new(phrase_params)
    phrase.audio_video_id = audio_video.id

    if phrase.save
      render :json => phrase
    else
      render :json => phrase.errors, :status => 409
    end
  end

  def destroy
    @phrase = Phrase.find(phrase_id)
    render :json => @phrase.destroy
  end

  private

  def phrase_id
    params.required(:id)
  end

  def audio_video_id
    params.required(:audio_video_id)
  end

  def phrase_params
    params.required(:phrase).permit(:name)
  end
end
