class Admin::TedTranscriptsController < ApplicationController

  def show
    transcript = TedTranscriptScrapper.getFromHtml(
      params[:url], params[:shift].to_f
    )

    render :text => transcript
  end
end
