require 'spec_helper'

describe Storage::IpStore do

  let(:store) { Storage::IpStore.new }
  let(:client) { double }

  before :each do
    expect(Api::IpClient).to receive(:new) { client }
    expect(store).to receive(:validate_response).with(response).and_call_original
  end

  describe '#get_ip_details' do
    let(:ip) { double('ip') }
    let(:ip_detail) { double('detail') }
    let(:response) { double(success: true, body: ip_detail) }
    subject { store.get_ip_details(ip) }

    before :each do
      expect(client).to receive(:get_details).with(ip) { response }
    end

    context 'response - success' do
      it 'should return ip_details' do
        expect(store).to receive(:build_ip_details).with(response).and_call_original
        expect(Domains::IpDetail).to receive(:new).with(ip_detail) { 'Ip Detail' }

        expect(subject).to eq 'Ip Detail'
      end
    end

    context 'response - error' do
      let(:response) { double(success: false, body: {error_description: nil}) }
      it 'should raise an error when response is not success' do
        expect(Domains::IpDetail).not_to receive(:new)

        expect { subject }.to raise_error Exceptions::AppExceptions::ApiError
      end
    end
  end
end

