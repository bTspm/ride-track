require 'spec_helper'

describe Services::IpService do

  it_should_behave_like  'controllers_concerns_services_spec'

  subject(:service) { described_class.new }

  describe '#get_ip_details' do
    let(:ip_or_domain) { double('ip_or_domain') }
    let(:ip_storage) { double('ip_storage') }

    subject { service.get_ip_details(ip_or_domain) }

    it 'should expect to call ip storage' do
      expect(service).to receive(:ip_storage) { ip_storage }
      expect(ip_storage).to receive(:get_ip_details).with(ip_or_domain) { 'IP Details' }

      expect(subject).to eq 'IP Details'
    end
  end

  describe '#get_ip_quality_details' do
    let(:ip) { double('ip') }
    let(:ip_quality_storage) { double('ip_quality_storage') }

    subject { service.get_ip_quality_details(ip) }

    it 'should expect to call ip quality storage' do
      expect(service).to receive(:ip_quality_storage) { ip_quality_storage }
      expect(ip_quality_storage).to receive(:get_ip_quality_details).with(ip) { 'IP Quality Details' }

      expect(subject).to eq 'IP Quality Details'
    end
  end
end

