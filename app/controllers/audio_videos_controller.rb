class AudioVideosController < ApplicationController
  PER_PAGE=24
  before_filter :load_categories, only: [:index, :show]
  before_filter :authenticate_user!, only: [:edit]

  def index
    load_category # can be nil
    @category_id = @category && @category.id
    @order = params[:order]

    @audio_videos = AudioVideo.includes(:level).
      by_status(AudioVideo::ACTIVE).
      by_category(@category).
      page(params[:page]).per(PER_PAGE).
      order("#{get_order_column(@order)} desc")
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
  def get_order_column(key)
    h = Hash.new('created_at')
    h['popular'] = 'views_count'

    h[key]
  end

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
