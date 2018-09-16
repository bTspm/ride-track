require 'spec_helper'

describe Domains::RideTrack::BaseProduct do

  subject {Domains::RideTrack::BaseProduct.new}

  describe '#properties' do
    it 'should return direct properties' do
      expect(subject.has_price_details?).to eq false
      expect(subject.pay_in_cash?).to eq false
      expect(subject.shared?).to eq false
    end
  end

end