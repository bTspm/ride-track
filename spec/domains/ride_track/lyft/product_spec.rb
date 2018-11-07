require 'spec_helper'

describe Domains::RideTrack::Lyft::Product do

  let(:response) {build_response.with_indifferent_access}
  let(:ins) {::Domains::RideTrack::Lyft::Product}

  describe '#initialize' do
    subject {ins.new(response: response)}
    context 'direct properties and instances' do
      it 'should return instance with properties' do
        result = subject
        expect(result).to be_kind_of Domains::RideTrack::Lyft::Product
        expect(result.capacity).to eq 2
        expect(result.image).to eq 'https://cdn.lyft.com/assets/car_standard.png'
        expect(result.id).to eq 'lyft_line'
        expect(result.pay_in_cash?).to eq false
        expect(result.provider).to eq 'lyft'
      end
    end
  end

  describe '#display_name' do
    subject {ins.new(response: response).display_name}
    context 'with display name' do
      it 'should return display name' do
        expect(subject).to eq 'Lyft Shared'
      end
    end

    context 'without display name' do
      let(:response) {{a: 1}}
      it 'should return empty' do
        expect(subject).to eq ''
      end
    end
  end

  describe '#shared?' do
    subject {ins.new(response: response).shared?}
    context 'shared in name' do
      it 'should return true' do
        expect(subject).to eq true
      end
    end

    context 'shared not in name' do
      let(:response) {{display_name: 'Private'}}
      it 'should return true' do
        expect(subject).to eq false
      end
    end
  end

  describe 'price details' do
    subject {ins.new(response: response)}
    context 'with price details' do
      it 'should return nil if no price details are provided' do
        expect(subject.base_price).to eq 2.1
        expect(subject.cost_per_minute).to eq 0.21
        expect(subject.cost_per_distance).to eq 1.35
        expect(subject.cancellation_fee).to eq 5.0
        expect(subject.minimum).to eq 3.50
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
    JSON.parse(File.read("#{::Rails.root}/spec/fixtures/ride_track/lyft/products.json"))['ride_types'].first
  end

end