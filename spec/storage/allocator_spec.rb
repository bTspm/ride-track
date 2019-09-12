require 'spec_helper'

describe Storage::Allocator do

  subject(:allocator) {Storage::Allocator.new}

  describe '#currency_store' do
    subject { allocator.currency_store }

    it { is_expected.to be_kind_of Storage::CurrencyStore }
  end

  describe '#ip_quality_store' do
    subject { allocator.ip_quality_store }

    it { is_expected.to be_kind_of Storage::IpQualityStore }
  end

  describe '#ip_store' do
    subject { allocator.ip_store }

    it { is_expected.to be_kind_of Storage::IpStore }
  end

  describe '#lyft_store' do
    subject { allocator.lyft_store }

    it { is_expected.to be_kind_of Storage::RideTrack::LyftStore }
  end

  describe '#uber_store' do
    subject { allocator.uber_store }

    it { is_expected.to be_kind_of Storage::RideTrack::UberStore }
  end
end

