require 'spec_helper'

describe Services::BusinessService do

  let(:engine) { double }
  subject(:business_service) { Services::BusinessService.new(engine: engine) }

  describe 'initialize' do
    context 'with engine' do
      it 'should return the argument engine' do
        expect(business_service.engine).to eq engine
      end
    end

    context 'without engine' do
      let(:engine) { nil }
      it 'should initialize a new engine as allocator' do
        expect(subject.engine).to be_kind_of Storage::Allocator
      end
    end
  end

  describe '#currency_storage' do
    subject { business_service.currency_storage }

    it 'should expect to call currency_store on engine' do
      expect(engine).to receive(:currency_store) { 'Currency Store' }

      expect(subject).to eq 'Currency Store'
    end
  end

  describe '#ip_storage' do
    subject { business_service.ip_storage }

    it 'should expect to call ip_store on engine' do
      expect(engine).to receive(:ip_store) { 'Ip Store' }

      expect(subject).to eq 'Ip Store'
    end
  end

  describe '#lyft_storage' do
    subject { business_service.lyft_storage }

    it 'should expect to call lyft_store on engine' do
      expect(engine).to receive(:lyft_store) { 'Lyft Store' }

      expect(subject).to eq 'Lyft Store'
    end
  end

  describe '#uber_storage' do
    subject { business_service.uber_storage }

    it 'should expect to call uber_store on engine' do
      expect(engine).to receive(:uber_store) { 'Uber Store' }

      expect(subject).to eq 'Uber Store'
    end
  end
end

