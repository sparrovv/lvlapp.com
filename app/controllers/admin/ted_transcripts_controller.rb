class Admin::TedTranscriptsController < Admin::BaseController

  # visit the video page
  #   web-console: talkDetails.mediaPad
        # it can be 11.82 or 15.33 or ...
  #   choose: transcript check the url (http://www.ted.com/talks/subtitles/id/848/lang/en/format/html)

  # example:
  # /ted_transcripts?url=http://....&shift=
  #
  def new
  end

  def create
    @transcript = TedTranscriptScrapper.getFromHtml(
      params[:url], params[:shift].to_f
    )

    render :new
  end
end
