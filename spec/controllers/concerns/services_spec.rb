require 'spec_helper'

describe Services do

  class DummyClass
    include Services
  end

  subject {DummyClass.new}

  describe 'ride_track_service' do
    it 'should initialize service' do
      expect(subject.ride_track_service).to be_kind_of Services::RideTrackService
    end
  end
end
