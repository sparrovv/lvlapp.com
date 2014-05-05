class Admin::TedTranscriptsController < Admin::BaseController

  def new
  end

  def create
    @transcript = TedTranscriptScrapper.from_json(
      params[:url], params[:shift].to_f
    )

    render :new
  end
end
