class AudioVideosController < ApplicationController
  before_filter :load_categories

  def index
    @category = load_category # can be nil
    @audio_videos = AudioVideo.
      by_status(AudioVideo::ACTIVE).
      by_category(@category).order('created_at desc')
  end

  def show
    @audio_video = AudioVideo.find(params[:id])
    view_counter.increment(@audio_video, cookies)
  end

  private
  def load_categories
    @categories = Category.all
  end

  def load_category
    @category = Category.where(id: params[:category_id]).first
  end

  def view_counter
    ViewCounter.new
  end
end
