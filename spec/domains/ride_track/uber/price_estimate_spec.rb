require 'spec_helper'

describe Domains::RideTrack::Uber::PriceEstimate do

  let!(:response) {build_response.with_indifferent_access}

  subject {Domains::RideTrack::Uber::PriceEstimate.new(response: response)}

  describe '#initialize' do
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

    context 'properties' do
      it 'should return instance with properties' do
        result = subject
        expect(result.display_name).to eq 'UberPool'
        expect(result.distance).to eq 40
        expect(result.duration).to eq 3180
        expect(result.currency_code).to eq 'USD'
        expect(result.provider).to eq 'uber'
        expect(result.distance_unit).to eq 'mile'
        expect(result.product_id).to eq '997acbb5-e102-41e1-b155-9df7de0a73f2'
      end
    end
  end

  describe '#high_estimate' do
    it 'should return estimate value in 100s' do
      expect(subject.high_estimate).to eq 76
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
      expect(subject.low_estimate).to eq 61
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
      expect(subject.duration_in_minutes).to eq 53
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
    JSON.parse(File.read("#{::Rails.root}/spec/fixtures/ride_track/uber/estimates.json"))['prices'].first
  end

end