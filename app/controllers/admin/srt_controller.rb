class Admin::SrtController < Admin::BaseController
  def new
  end

  def create
    foo = SRT::File.parse(params[:content])

    @srt = [];foo.lines.each do |line|
      @srt << {time: line.start_time.round(3), text: line.text.join(' ')}
    end

    render :show
  end

  def shift
    render :shift
  end
end
