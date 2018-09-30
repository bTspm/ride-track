require 'spec_helper'

describe Services::BusinessService do

  let(:engine) {double}
  subject {Services::BusinessService.new(engine: engine)}

  describe 'initialize' do
    context 'with engine' do
      it 'should return the argument engine' do
        expect(subject.engine).to eq engine
      end
    end

    context 'without engine' do
      let(:engine) {nil}
      it 'should initialize a new engine as allocator' do
        expect(subject.engine).to be_kind_of Storage::Allocator
      end
    end
  end

  describe 'properties' do
    before :each do
      allow(engine).to receive(:uber_store) {'Uber Store'}
      allow(engine).to receive(:lyft_store) {'Lyft Store'}
    end

    it 'should return the stores' do
      expect(subject.uber_storage).to eq 'Uber Store'
      expect(subject.lyft_storage).to eq 'Lyft Store'
    end
  end
end