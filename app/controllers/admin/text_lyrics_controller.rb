class Admin::TextLyricsController < Admin::BaseController
  def new
  end

  def create
    @duration = params['duration']
    @lyrics = params['content']
    @transcript = structured_lrc(@duration, @lyrics)

    render :new
  end

  def structured_lrc(duration, lyrics)
    splitted_lyrics = lyrics.split("\n").map(&:strip)
    line_per_sec = duration.to_i / splitted_lyrics.size

    timing = (1..duration.to_i).map{|l| l if l%line_per_sec.to_i == 0  }.delete_if{|l| l.nil?}

    timing.zip(splitted_lyrics).map{|arry| {'time' => arry[0], 'text' => arry[1].to_s}}
  end
end
