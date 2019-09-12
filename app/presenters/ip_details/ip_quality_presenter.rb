module Presenters::IpDetails
  class IpQualityPresenter
    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter
      def abuse_details
        values = recent_abuse ? _abuse_true_values : _abuse_false_values
        { label: 'Abuse', icon: 'fas fa-ban fa-2x ', **values }
      end

      def bot_details
        values = bot_status ? _bot_true_values : _bot_false_values
        { label: 'Bot', icon: 'fas fa-robot fa-2x ', **values }
      end

      def crawler_details
        values = is_crawler ? _crawler_true_values : _crawler_false_values
        { label: 'Crawler', icon: 'fas fa-spider fa-2x ', **values }
      end

      def fraud_score_details
        {
          label: 'Fraud Score',
          icon: 'fas fa-clipboard-list fa-2x',
          value_prefix: "#{fraud_score}/100",
          **_fraud_score_values
        }
      end

      def mobile_details
        values = mobile ? _mobile_true_values : _mobile_false_values
        { label: 'Mobile', icon: 'fas fa-mobile fa-2x ', **values }
      end

      def proxy_details
        values = proxy ? _proxy_true_values : _proxy_false_values
        { label: 'Proxy', icon: 'fas fa-server fa-2x ', **values }
      end

      def tor_details
        values = tor ? _tor_true_values : _tor_false_values
        { label: 'TOR', icon: 'far fa-window-close fa-2x ', **values }
      end

      def vpn_details
        values = vpn ? _vpn_true_values : _vpn_false_values
        { label: 'VPN', icon: 'fas fa-shield-alt fa-2x ', **values }
      end

      private

      def _abuse_false_values
        { value: 'No abuse detected', left_border_class: 'success-left', text_class: 'text-success' }
      end

      def _abuse_true_values
        { value: 'Abuse detected', left_border_class: 'danger-left', text_class: 'text-danger' }
      end

      def _bot_false_values
        { value: 'No Activity Detected', left_border_class: 'success-left', text_class: 'text-success' }
      end

      def _bot_true_values
        { value: 'Activity Detected', left_border_class: 'warning-left', text_class: 'text-warning' }
      end

      def _crawler_false_values
        { value: 'Not a Crawler', left_border_class: 'success-left', text_class: 'text-success' }
      end

      def _crawler_true_values
        { value: 'Crawler Detected', left_border_class: 'warning-left', text_class: 'text-warning' }
      end

      def _fraud_score_values
        case fraud_score
          when 0..33
            _fraud_score_low_values
          when 34..66
            _fraud_score_medium_values
          when 67..100
            _fraud_score_high_values
          else
            { error: "Unknown #{fraud_score}" }
        end
      end

      def _fraud_score_high_values
        { value_suffix: 'Danger', text_class: 'text-danger', left_border_class: 'danger-left' }
      end

      def _fraud_score_low_values
        { value_suffix: 'Low Risk', text_class: 'text-success', left_border_class: 'success-left' }
      end

      def _fraud_score_medium_values
        { value_suffix: 'Suspicious', text_class: 'text-warning', left_border_class: 'warning-left' }
      end

      def _mobile_false_values
        { value: 'Not mobile', left_border_class: 'info-left', text_class: 'text-info' }
      end

      def _mobile_true_values
        { value: 'Connection detected', left_border_class: 'info-left', text_class: 'text-info' }
      end

      def _proxy_false_values
        { value: 'Not proxy', left_border_class: 'success-left', text_class: 'text-success' }
      end

      def _proxy_true_values
        { value: 'Connection detected', left_border_class: 'danger-left', text_class: 'text-danger' }
      end

      def _tor_false_values
        { value: 'Not TOR', left_border_class: 'success-left', text_class: 'text-success' }
      end

      def _tor_true_values
        { value: 'TOR detected', left_border_class: 'danger-left', text_class: 'text-danger' }
      end

      def _vpn_false_values
        { value: 'Not VPN', left_border_class: 'success-left', text_class: 'text-success' }
      end

      def _vpn_true_values
        { value: 'VPN detected', left_border_class: 'danger-left', text_class: 'text-danger' }
      end
    end
  end
end

