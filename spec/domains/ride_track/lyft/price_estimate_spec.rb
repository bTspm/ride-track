require 'spec_helper'

describe Domains::RideTrack::Lyft::PriceEstimate do

  let(:response) {build_response.with_indifferent_access}

  subject {Domains::RideTrack::Lyft::PriceEstimate.new(response: response)}

  describe '#initialize' do
    context 'direct properties' do
      it 'should return instance with properties' do
        result = subject
        expect(result.display_name).to eq 'Shared'
        expect(result.distance).to eq 42.82
        expect(result.duration).to eq 3154
        expect(result.currency_code).to eq 'USD'
        expect(result.provider).to eq 'lyft'
        expect(result.distance_unit).to eq 'mile'
        expect(result.product_id).to eq 'lyft_line'
      end
    end
  end

  describe '#high_estimate' do
    it 'should return estimate value in 100s' do
      expect(subject.high_estimate).to eq 70
    end
    context 'no max price value' do
      let(:response) {{a: ''}}
      it 'should return 0 when no no max value is provided' do
        expect(subject.high_estimate).to eq 0
      end
    end
  end

  describe '#low_estimate' do
    it 'should return estimate value in 100s' do
      expect(subject.low_estimate).to eq 65
    end
    context 'no min price value' do
      let(:response) {{a: ''}}
      it 'should return 0 when no no max value is provided' do
        expect(subject.low_estimate).to eq 0
      end
    end
  end

  describe '#surge_value' do
    it 'should return the calculated surge value' do
      expect(subject.surge_value).to eq 1.25
    end
    context 'no prime-time percentage' do
      let(:response) {{a: ''}}
      it 'should return the value as 0' do
        expect(subject.surge_value).to eq 0
      end
    end
  end

  describe '#duration_in_minutes' do
    it 'should return the calculated surge value' do
      expect(subject.duration_in_minutes).to eq 52
    end
    context 'no duration' do
      let(:response) {{a: ''}}
      it 'should return the value as 0' do
        expect(subject.duration_in_minutes).to eq 0
      end
    end
  end

  private

  def build_response
    JSON.parse(File.read("#{::Rails.root}/spec/fixtures/ride_track/lyft/estimates.json"))['cost_estimates'].first
  end

end