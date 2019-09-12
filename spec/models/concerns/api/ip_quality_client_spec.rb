require 'spec_helper'

describe Api::IpQualityClient do

  subject(:client) { described_class.new }

  describe '#initialize' do
    it 'should initialize client' do
      expect(client).to be_kind_of described_class
    end
  end

  describe '#get_details' do
    let(:ip) { double('ip') }
    let(:params) do
      {
        url: "#{ip}?strictness=3",
        cache_key: "#{ip}-quality",
        expire_time: 86_400
      }
    end
    subject { client.get_details(ip) }
    it 'should call get with uri and cache_key' do
      expect(client).to receive(:get).with(params) { 'IP Quality Details' }

      subject
    end
  end
end

