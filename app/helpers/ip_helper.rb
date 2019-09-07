module IpHelper

  def quality_detail_format(options = {})
    left_border_class = options[:left_border_class].presence || 'info-left'
    content_tag :div, class: 'col-md quality-detail' do
      content_tag :div, class: "card #{left_border_class}" do
        content_tag :div, class: 'card-body ' do
          content_tag :div, class: 'row align-items-center' do
            concat _quality_text_format(options)
            concat _quality_icon_format(options)
          end
        end
      end
    end
  end

  def fraud_score_format(options = {})
    options[:value] = _fraud_score_format(options)
    quality_detail_format(options)
  end

  private

  def _fraud_score_format(options = {})
    content_tag :b do
      concat _score_format(options[:value_prefix])
      concat content_tag :span, options[:value_suffix], class: options[:text_class]
    end
  end

  def _quality_text_format(options = {})
    content_tag :div, class: 'col' do
      concat(content_tag :h4, options[:label])
      concat(content_tag :small, options[:value], class: options[:value_text_class])
    end
  end

  def _quality_icon_format(options = {})
    content_tag :div, class: 'col-auto text-right' do
      fontawesome_icon("#{options[:icon]} #{options[:text_class]}")
    end
  end

  def _score_format(value)
    content_tag :b do
      concat content_tag :span, value, class: 'badge badge-pill badge-info'
      concat content_tag :span, " - "
    end
  end
end

