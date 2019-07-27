require 'spec_helper'

describe Api::CacheTime do

  class DummyClass
    include Api::CacheTime
  end

  subject(:dummy_class) { DummyClass.new }

  describe 'calc_top_of_hour' do
    let(:time) { Time.new(2019, 10, 12) + 30.minutes }

    subject { dummy_class.calc_top_of_hour }

    it 'should return calculated remaining seconds on hours' do
      expect(dummy_class).to receive(:_time_now) { time }

      expect(subject).to eq 1_800
    end
  end
end

