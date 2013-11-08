class Admin::YoutubeParserController < Admin::BaseController
  def new
  end

  def create
    @transcript= YoutubeTranscriptParser.parse(params[:content])
    render :show
  end
end
