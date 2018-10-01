require 'spec_helper'

describe Storage::Allocator do

  subject {Storage::Allocator.new}

  describe 'uber_store' do
    it 'should initialize uber_store' do
      expect(subject.uber_store).to be_kind_of Storage::RideTrack::UberStore
    end
  end

  describe 'lyft_store' do
    it 'should initialize lyft_store' do
      expect(subject.lyft_store).to be_kind_of Storage::RideTrack::LyftStore
    end
  end
end
