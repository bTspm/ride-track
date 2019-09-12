require 'spec_helper'

describe Api::IpClient do

  subject(:client) { Api::IpClient.new }

  describe '#initialize' do
    it 'should initialize client' do
      expect(client).to be_kind_of described_class
    end
  end

  describe '#get_details' do
    let(:ip) { double('ip') }
    let(:params) do
      {
        url: "#{ip}?fields=12845055",
        cache_key: ip,
        expire_time: 86_400
      }
    end
    subject { client.get_details(ip) }
    it 'should call get with uri and cache_key' do
      expect(client).to receive(:get).with(params) { 'IP Details' }

      subject
    end
  end
end

