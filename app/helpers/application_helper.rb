module ApplicationHelper
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
end
