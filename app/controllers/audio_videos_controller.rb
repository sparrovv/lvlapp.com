class AudioVideosController < ApplicationController
  before_filter :load_categories, only: [:index, :show]
  before_filter :authenticate_user!, only: [:edit]

  def index
    @category = load_category # can be nil
    @audio_videos = AudioVideo.includes(:level).
      by_status(AudioVideo::ACTIVE).
      by_category(@category).order('created_at desc')
  end

  def show
    @audio_video = AudioVideo.friendly.find(params[:id])
    view_counter.increment(@audio_video, cookies)
  end

  def edit
    raise 'You have to be ADMIN' unless current_user.admin?

    @audio_video = AudioVideo.friendly.find(params[:id])
  end

  def update
    @audio_video = AudioVideo.friendly.find(params[:id])
    @audio_video.duration = duration
    @audio_video.save

    render json: @audio_video, status: 200
  end

  private
  def load_categories
    @categories = Category.order(:position)
  end

  def load_category
    @category = Category.where(id: params[:category_id]).first
  end

  def view_counter
    ViewCounter.new
  end

  def duration
    params.required(:duration)
  end
end
