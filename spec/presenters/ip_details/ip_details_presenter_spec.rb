require 'spec_helper'

describe Presenters::IpDetails::IpDetailsPresenter do

  let(:view_context) { ActionController::Base.new }
  let(:address) { double('address') }
  let(:ip_detail) { double('ip_detail', address: address) }

  describe '.scalar' do
    subject(:scalar) { described_class.present(ip_detail, view_context) }

    describe '#address' do
      subject { scalar.address }
      it 'should create a address presenter' do
        expect(Presenters::AddressesPresenter).to receive(:present).with(address, view_context) { 'Address' }
        expect(subject).to eq 'Address'
      end
    end
  end
end

