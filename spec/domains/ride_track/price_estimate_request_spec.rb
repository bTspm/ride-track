require 'spec_helper'

describe Domains::RideTrack::PriceEstimateRequest do

  let(:origin_details) {{latitude: 1, longitude: 2}}
  let(:destination_details) {{latitude: 2, longitude: 3}}
  subject do
    described_class.new(origin_details: origin_details, destination_details: destination_details)
  end

  describe '#initialize' do
    context 'instance and properties' do
      before :each do
        allow(Domains::Address).to receive(:new).with(details: origin_details) {'Origin Address'}
        allow(Domains::Address).to receive(:new).with(details: destination_details) {'Destination Address'}
      end
      it 'should return instance and properties' do
        result = subject
        expect(result).to be_kind_of described_class
        expect(result.origin).to eq 'Origin Address'
        expect(result.destination).to eq 'Destination Address'
      end
    end

    context 'validation errors' do
      context 'origin details are empty' do
        let(:origin_details) {{}}
        it 'should raise an error' do
          expect {subject}.to raise_error Exceptions::AppExceptions::InvalidParameters
        end
      end

      context 'destination details are empty' do
        let(:destination_details) {{}}
        it 'should raise an error' do
          expect {subject}.to raise_error Exceptions::AppExceptions::InvalidParameters
        end
      end

      context 'both origin and destination details are empty' do
        let(:destination_details) {{}}
        let(:origin_details) {{}}
        it 'should raise an error' do
          expect {subject}.to raise_error Exceptions::AppExceptions::InvalidParameters
        end
      end
    end
  end
end
