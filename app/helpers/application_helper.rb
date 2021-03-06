module ApplicationHelper
  def fontawesome_icon(name_icon_with_style, text = nil, html_options = {})
    text, html_options = nil, text if text.is_a?(Hash)

    content_class = name_icon_with_style
    content_class << " #{html_options[:class]}" if html_options.key?(:class)
    html_options[:class] = content_class

    html = content_tag(:i, nil, html_options)
    html << ' ' << text.to_s unless text.blank?
    html
  end
end

