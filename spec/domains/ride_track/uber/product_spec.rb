require 'spec_helper'

describe Domains::RideTrack::Uber::Product do

  let(:response) {build_response.with_indifferent_access}
  let(:ins) {::Domains::RideTrack::Uber::Product}

  describe '#initialize' do
    subject {ins.new(response: response)}
    context 'response nil' do
      let(:response) {nil}
      it 'should raise an error' do
        expect {subject}.to raise_error ArgumentError
      end
    end

    context 'response empty' do
      let(:response) {{}}
      it 'should raise an error' do
        expect {subject}.to raise_error ArgumentError
      end
    end

    context 'direct properties and instances' do
      it 'should return instance with properties' do
        result = subject
        expect(result).to be_kind_of Domains::RideTrack::Uber::Product
        expect(result.capacity).to eq 2
        expect(result.image).to eq 'https://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-uberpool.png'
        expect(result.display_name).to eq 'UberPool'
        expect(result.shared?).to eq true
        expect(result.id).to eq '997acbb5-e102-41e1-b155-9df7de0a73f2'
        expect(result.pay_in_cash?).to eq false
      end
    end
  end

  describe 'price details' do
    subject {ins.new(response: response)}
    context 'with price details' do
      it 'should return nil if no price details are provided' do
        expect(subject.base_price).to eq 2.1
        expect(subject.cost_per_minute).to eq 0.16
        expect(subject.cost_per_distance).to eq 1.28
        expect(subject.cancellation_fee).to eq 5.0
        expect(subject.minimum).to eq 6.85
        expect(subject.currency_code).to eq 'USD'
        expect(subject.distance_unit).to eq 'mile'
        expect(subject.has_price_details?).to eq true
      end
    end

    context 'without price details' do
      let(:response) {{a: 1}}
      it 'should return nil if no price details are provided' do
        expect(subject.base_price).to be_nil
        expect(subject.cost_per_minute).to be_nil
        expect(subject.cost_per_distance).to be_nil
        expect(subject.cancellation_fee).to be_nil
        expect(subject.minimum).to be_nil
        expect(subject.currency_code).to be_nil
        expect(subject.distance_unit).to be_nil
        expect(subject.has_price_details?).to eq false
      end
    end
  end

  private

  def build_response
    JSON.parse(File.read("#{::Rails.root}/spec/fixtures/ride_track/uber/products.json"))['products'].first
  end

end