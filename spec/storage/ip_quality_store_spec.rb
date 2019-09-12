require 'spec_helper'

describe Storage::IpQualityStore do

  let(:store) { described_class.new }
  let(:client) { double('client') }

  before :each do
    expect(Api::IpQualityClient).to receive(:new) { client }
  end

  describe '#get_ip_quality_details' do
    let(:ip) { double('ip') }
    let(:ip_quality_detail) { {status: ip_response_status} }
    let(:ip_response_status) { 'success' }
    let(:response) { double(success: true, body: ip_quality_detail) }
    subject { store.get_ip_quality_details(ip) }

    before :each do
      expect(client).to receive(:get_details).with(ip) { response }
    end

    context 'response - success' do
      it 'should return ip_quality_details' do
        expect(Domains::Ip::QualityDetail).to receive(:new).with(ip_quality_detail) { 'Ip Quality Detail' }

        expect(subject).to eq 'Ip Quality Detail'
      end
    end

    context 'response - error' do
      before :each do
        expect(Domains::Ip::IpDetail).not_to receive(:new)
      end

      context 'when response is not success' do
        let(:response) { double(success: false, body: { error_description: nil }) }
        it { expect { subject }.to raise_error Exceptions::AppExceptions::ApiError }
      end
    end
  end
end

