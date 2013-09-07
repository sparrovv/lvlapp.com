class PhrasesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_audio_video

  def index
    @phrases = current_user.phrases_by_audio_video(@audio_video)
    render :json => @phrases
  end

  def create
    phrase = Phrase.new(phrase_params).tap do |phrase|
      phrase.audio_video = @audio_video
      phrase.user = current_user
    end

    if phrase.save
      render :json => phrase
    else
      render :json => phrase.errors, :status => 409
    end
  end

  def destroy
    @phrase = Phrase.find(phrase_id)
    if @phrase.user == current_user
      render :json => @phrase.destroy
    else
      render :text => 'Forbiden fot this user', :status => 403
    end
  end

  private

  def load_audio_video
    @audio_video = AudioVideo.find audio_video_id
  end

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
