require 'spec_helper'

describe Presenters::Currency::ExchangeRatePresenter do

  let(:view_context) { ActionController::Base.new }
  let(:locals) { {} }
  let(:number) { 10 }
  let(:from_currency) { double }
  let(:to_currency) { double }
  let(:from) { double }
  let(:to) { double }
  let(:rate) { double }

  let(:exchange_rate) do
    double(
      from_currency: from_currency,
      to_currency: to_currency,
      from: from,
      to: to,
      rate: rate
    )
  end

  describe '.scalar' do
    subject(:scalar) { described_class.present(exchange_rate, view_context, locals) }

    describe '#from_currency' do
      subject { scalar.from_currency }
      it 'should create currency presenter' do
        expect(
          Presenters::Currency::CurrenciesPresenter
        ).to receive(:present).with(from_currency, view_context) { 'From Currency' }

        expect(subject).to eq 'From Currency'
      end
    end

    describe '#from_currency_base' do
      subject { scalar.from_currency_base(number) }
      
      it { is_expected.to eq "#{number} #{from}" }
    end

    describe '#from_currency_calc_amount' do
      subject { scalar.from_currency_calc_amount(number) }
      
      it 'should return calculated amount with to code' do
        expect(scalar).to receive(:to_rounded_rate) { 10 }
        
        expect(subject).to eq "100 #{to}"
      end
    end

    describe '#to_currency' do
      subject { scalar.to_currency }
      it 'should create currency presenter' do
        expect(
          Presenters::Currency::CurrenciesPresenter
        ).to receive(:present).with(to_currency, view_context) { 'From Currency' }

        expect(subject).to eq 'From Currency'
      end
    end

    describe '#to_currency_base' do
      subject { scalar.to_currency_base(number) }

      it { is_expected.to eq "#{number} #{to}" }
    end

    describe '#to_currency_calc_amount' do
      subject { scalar.to_currency_calc_amount(number) }

      it 'should return calculated amount with to code' do
        expect(scalar).to receive(:to_rounded_rate) { 10 }

        expect(subject).to eq "1 #{from}"
      end
    end

    describe '#to_rounded_rate' do
      let(:rate) { 100.999999 }
      subject { scalar.to_rounded_rate }

      it { is_expected.to eq 101.0 }
    end
  end

  describe '.enum' do
    let(:to_code) { 'USD' }
    let(:from_code) { 'INR' }
    subject(:enum) { described_class.present([exchange_rate], view_context, locals) }

    describe '#rate_by_currency' do
      subject { enum.rate_by_currency(to_code: to_code, from_code: from_code) }

      context 'to and from are same' do
        let(:from_code) { 'USD' }
        it { is_expected.to eq 1 }
      end

      context 'matched exchange rate' do
        let(:to) { 'USD' }
        let(:from) { 'INR' }
        it { is_expected.to eq rate }
      end

      context 'no exchange rate found' do
        subject { enum.rate_by_currency(to_code: from_code, from_code: to_code) }
        it { is_expected.to be_nil }
      end
    end
  end
end

