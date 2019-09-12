require 'spec_helper'

describe Presenters::IpDetails::IpQualityPresenter do

  let(:view_context) { ActionController::Base.new }
  let(:recent_abuse) { double('recent_abuse') }
  let(:bot_status) { double('bot_status') }
  let(:is_crawler) { double('is_crawler') }
  let(:fraud_score) { double('fraud_score') }
  let(:mobile) { double('mobile') }
  let(:proxy) { double('proxy') }
  let(:tor) { double('tor') }
  let(:vpn) { double('vpn') }
  let(:ip_quality_detail) do
    double(
      'ip_quality_detail',
      recent_abuse: recent_abuse,
      bot_status: bot_status,
      is_crawler: is_crawler,
      fraud_score: fraud_score,
      mobile: mobile,
      proxy: proxy,
      tor: tor,
      vpn: vpn,
      )
  end

  describe '.scalar' do
    subject(:scalar) { described_class.present(ip_quality_detail, view_context) }

    describe '#abuse_details' do
      subject { scalar.abuse_details }

      context 'default values' do
        it 'should return default abuse values' do
          expect(subject[:label]).to eq 'Abuse'
          expect(subject[:icon]).to eq 'fas fa-ban fa-2x '
        end
      end

      context 'abuse - false' do
        let(:recent_abuse) { false }
        it 'should return abuse false values' do
          result = { value: 'No abuse detected', left_border_class: 'success-left', text_class: 'text-success' }
          expect(subject).to include result
        end
      end

      context 'abuse - true' do
        it 'should return abuse true values' do
          result = { value: 'Abuse detected', left_border_class: 'danger-left', text_class: 'text-danger' }
          expect(subject).to include result
        end
      end
    end

    describe '#bot_details' do
      subject { scalar.bot_details }

      context 'default values' do
        it 'should return default Bot values' do
          expect(subject[:label]).to eq 'Bot'
          expect(subject[:icon]).to eq 'fas fa-robot fa-2x '
        end
      end

      context 'bot - false' do
        let(:bot_status) { false }
        it 'should return Bot false values' do
          result = { value: 'No Activity Detected', left_border_class: 'success-left', text_class: 'text-success' }
          expect(subject).to include result
        end
      end

      context 'bot - true' do
        it 'should return Bot true values' do
          result = { value: 'Activity Detected', left_border_class: 'warning-left', text_class: 'text-warning' }
          expect(subject).to include result
        end
      end
    end

    describe '#crawler_details' do
      subject { scalar.crawler_details }

      context 'default values' do
        it 'should return default Crawler values' do
          expect(subject[:label]).to eq 'Crawler'
          expect(subject[:icon]).to eq 'fas fa-spider fa-2x '
        end
      end

      context 'Crawler - false' do
        let(:is_crawler) { false }
        it 'should return Crawler false values' do
          result = { value: 'Not a Crawler', left_border_class: 'success-left', text_class: 'text-success' }
          expect(subject).to include result
        end
      end

      context 'Crawler - true' do
        it 'should return Crawler true values' do
          result = { value: 'Crawler Detected', left_border_class: 'warning-left', text_class: 'text-warning' }
          expect(subject).to include result
        end
      end
    end

    describe '#fraud_score_details' do
      subject { scalar.fraud_score_details }

      context 'default values' do
        it 'should return default fraud_score values' do
          expect(subject[:label]).to eq 'Fraud Score'
          expect(subject[:icon]).to eq 'fas fa-clipboard-list fa-2x'
          expect(subject[:value_prefix]).to eq "#{fraud_score}/100"
        end
      end

      context 'when score is between 0-33' do
        let(:fraud_score) { 25 }

        it 'should return fraud_score low values' do
          result = { value_suffix: 'Low Risk', text_class: 'text-success', left_border_class: 'success-left' }
          expect(subject).to include result
        end
      end

      context 'when score is between 34-66' do
        let(:fraud_score) { 50 }

        it 'should return fraud_score medium values' do
          result = { value_suffix: 'Suspicious', text_class: 'text-warning', left_border_class: 'warning-left' }
          expect(subject).to include result
        end
      end

      context 'when score is between 67-100' do
        let(:fraud_score) { 75 }

        it 'should return fraud_score high values' do
          result = { value_suffix: 'Danger', text_class: 'text-danger', left_border_class: 'danger-left' }
          expect(subject).to include result
        end
      end

      context 'no fraud score' do
        let(:fraud_score) { 'No Fraud Score' }

        it 'should not return value' do
          result = { error: 'Unknown No Fraud Score' }
          expect(subject).to include result
        end
      end
    end

    describe '#mobile_details' do
      subject { scalar.mobile_details }

      context 'default values' do
        it 'should return default mobile values' do
          expect(subject[:label]).to eq 'Mobile'
          expect(subject[:icon]).to eq 'fas fa-mobile fa-2x '
        end
      end

      context 'Mobile - false' do
        let(:mobile) { false }
        it 'should return mobile false values' do
          result = { value: 'Not mobile', left_border_class: 'info-left', text_class: 'text-info' }
          expect(subject).to include result
        end
      end

      context 'Mobile - true' do
        it 'should return mobile true values' do
          result = { value: 'Connection detected', left_border_class: 'info-left', text_class: 'text-info' }
          expect(subject).to include result
        end
      end
    end

    describe '#proxy_details' do
      subject { scalar.proxy_details }

      context 'default values' do
        it 'should return default Proxy values' do
          expect(subject[:label]).to eq 'Proxy'
          expect(subject[:icon]).to eq 'fas fa-server fa-2x '
        end
      end

      context 'Proxy - false' do
        let(:proxy) { false }
        it 'should return Proxy false values' do
          result = { value: 'Not proxy', left_border_class: 'success-left', text_class: 'text-success' }
          expect(subject).to include result
        end
      end

      context 'Proxy - true' do
        it 'should return Proxy true values' do
          result = { value: 'Connection detected', left_border_class: 'danger-left', text_class: 'text-danger' }
          expect(subject).to include result
        end
      end
    end

    describe '#tor_details' do
      subject { scalar.tor_details }

      context 'default values' do
        it 'should return default TOR values' do
          expect(subject[:label]).to eq 'TOR'
          expect(subject[:icon]).to eq 'far fa-window-close fa-2x '
        end
      end

      context 'TOR - false' do
        let(:tor) { false }
        it 'should return TOR false values' do
          result = { value: 'Not TOR', left_border_class: 'success-left', text_class: 'text-success' }
          expect(subject).to include result
        end
      end

      context 'TOR - true' do
        it 'should return TOR true values' do
          result = { value: 'TOR detected', left_border_class: 'danger-left', text_class: 'text-danger' }
          expect(subject).to include result
        end
      end
    end

    describe '#vpn_details' do
      subject { scalar.vpn_details }

      context 'default values' do
        it 'should return default abuse values' do
          expect(subject[:label]).to eq 'VPN'
          expect(subject[:icon]).to eq 'fas fa-shield-alt fa-2x '
        end
      end

      context 'VPN - false' do
        let(:vpn) { false }
        it 'should return VPN false values' do
          result = { value: 'Not VPN', left_border_class: 'success-left', text_class: 'text-success' }
          expect(subject).to include result
        end
      end

      context 'VPN - true' do
        it 'should return VPN true values' do
          result = { value: 'VPN detected', left_border_class: 'danger-left', text_class: 'text-danger' }
          expect(subject).to include result
        end
      end
    end
  end
end

