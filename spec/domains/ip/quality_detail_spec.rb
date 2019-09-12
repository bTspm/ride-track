require 'spec_helper'

describe Domains::Ip::QualityDetail do

  let(:bot_status) { double('bot_status') }
  let(:fraud_score) { 10 }
  let(:is_crawler) { double('is_crawler') }
  let(:mobile) { double('mobile') }
  let(:proxy) { double('proxy') }
  let(:recent_abuse) { double('recent_abuse') }
  let(:tor) { double('tor') }
  let(:vpn) { double('vpn') }

  let(:response) do
    {
      bot_status: bot_status,
      fraud_score: fraud_score,
      is_crawler: is_crawler,
      mobile: mobile,
      proxy: proxy,
      recent_abuse: recent_abuse,
      tor: tor,
      vpn: vpn
    }
  end

  subject(:ip_detail) { described_class.new(response) }

  describe '#initialize' do

    it { is_expected.to respond_to(:bot_status) }
    it { is_expected.to respond_to(:fraud_score) }
    it { is_expected.to respond_to(:is_crawler) }
    it { is_expected.to respond_to(:mobile) }
    it { is_expected.to respond_to(:proxy) }
    it { is_expected.to respond_to(:recent_abuse) }
    it { is_expected.to respond_to(:tor) }
    it { is_expected.to respond_to(:vpn) }

    context 'instance and properties' do
      it 'should return instance and properties' do
        result = ip_detail
        expect(result).to be_kind_of described_class
        expect(result.bot_status).to eq bot_status
        expect(result.fraud_score).to eq fraud_score
        expect(result.is_crawler).to eq is_crawler
        expect(result.mobile).to eq mobile
        expect(result.proxy).to eq proxy
        expect(result.recent_abuse).to eq recent_abuse
        expect(result.tor).to eq tor
        expect(result.vpn).to eq vpn
      end
    end
  end
end

