module ApplicationHelper
  SUPPORTED_NATIVE_LANGS=[
    'polish',
    'czech',
    'danish',
    'german',
    'finnish',
    'french',
    'spanish',
    'russian',
    'italian',
    'portuguese',
    'romanian',
    'ukrainian',
    'latvian',
    'dutch',
  ]
  def title(page_title)
    content_for :title, page_title.to_s
  end

  def show_title(title)
    "LvlApp - #{title}".html_safe
  end

  def flash_messages
    return if flash.empty?

    content_tag(:div, :class => 'flash-messages') do
      flash.collect do |type, message|
        content_tag(:div, :class => "#{to_bootstrap_css(type)}") do
          "<span>#{message}</span>".html_safe

          # @TODO: add support for closing that alerts
          # "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
        end
      end.join("\n").html_safe
    end
  end

  def to_bootstrap_css(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-error"
    when :alert then "alert alert-error"
    end
  end

  def common_languages_list
    common_langs = LanguageList::COMMON_LANGUAGES.
      select{|l| SUPPORTED_NATIVE_LANGS.include?(l.name.downcase) }.
      map{|l| [l.name, l.iso_639_1] }
    common_langs << ['Other', User::OTHER_NATIVE_LANG]
    common_langs
  end

  def video_level(level)
    "<span class='level-info v-level-#{level}'>#{level}</span>".html_safe
  end

  def video_duration(duration)
    m = duration.to_i / 60
    sec = duration.to_i % 60
    "<span class='duration' style='float:right'>#{add_zero(m)}:#{add_zero(sec)}</span>".html_safe
  end

  def active_class &block
    'active' if block.call == true
  end

  def add_zero(i)
    i < 10 ? "0#{i}" : i.to_s
  end
end
