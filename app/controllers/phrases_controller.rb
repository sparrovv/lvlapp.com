class PhrasesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_audio_video, except: [:sm2_update]

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
      PhraseWorker.enrich(phrase, current_user.native_language)
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

  def sm2_update
    phrases_ids = sm2_params.map{|h| h['id'] }
    current_user.phrases.where(id: phrases_ids).each do |phrase|
      attrs = sm2_params.find{ |e| e['id'].to_i == phrase.id }

      phrase.interval = attrs['interval']
      phrase.easiness_factor = attrs['easiness_factor']
      phrase.repetition_date = Time.at(attrs['repetition_date'].to_i/1000).to_date

      phrase.save!
    end

    render nothing: true, status: 201
  end

  private

  def sm2_params
    params.required(:phrases_sm2)
  end

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
    params.required(:phrase).permit(:name, :sentence)
  end
end
