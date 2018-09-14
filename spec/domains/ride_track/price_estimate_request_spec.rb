require 'spec_helper'

describe Domains::RideTrack::PriceEstimateRequest do


  let(:origin_details) {'Origin'}
  let(:destination_details) {'Destination'}
  subject do
    Domains::RideTrack::PriceEstimateRequest.new(
        origin_details: origin_details, destination_details: destination_details
    )
  end

  before :each do
    allow(Domains::Address).to receive(:new).with(details: 'Origin') {'Origin Address'}
    allow(Domains::Address).to receive(:new).with(details: 'Destination') {'Destination Address'}
  end

  describe '#initialize' do
    context 'instance and properties' do
      it 'should return instance and properties' do
        result = subject
        expect(result).to be_kind_of Domains::RideTrack::PriceEstimateRequest
        expect(result.origin).to eq 'Origin Address'
        expect(result.destination).to eq 'Destination Address'
      end
    end

    context 'origin details nil' do
      let(:origin_details) {nil}
      it 'should raise an error when details are empty' do
        expect {subject}.to raise_error ArgumentError
      end
    end

    context 'destination details nil' do
      let(:destination_details) {nil}
      it 'should raise an error when details are empty' do
        expect {subject}.to raise_error ArgumentError
      end
    end
  end

end