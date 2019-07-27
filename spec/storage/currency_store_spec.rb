require 'spec_helper'

describe Storage::CurrencyStore do

  let(:store) { Storage::CurrencyStore.new }
  let(:client) { double }

  before :each do
    expect(Api::CurrencyClient).to receive(:new) { client }
    expect(store).to receive(:validate_response).with(response).and_call_original
  end

  describe '#get_countries_with_currencies' do
    let(:value) { double }
    let(:results) { {k: value} }
    let(:response) { double(success: true, body: {results: results}) }
    subject { store.get_countries_with_currencies }

    before :each do
      expect(client).to receive(:get_countries_with_currencies) { response }
    end

    context 'response - success' do
      it 'should return countries_with_currencies' do
        expect(store).to receive(:build_countries).with(results).and_call_original
        expect(Domains::Currency::Country).to receive(:new).with(value) { 'Country' }

        expect(subject).to match_array ['Country']
      end
    end

    context 'response - error' do
      let(:response) { double(success: false, body: {error: nil}) }
      it 'should raise an error when response is not success' do
        expect(store).not_to receive(:build_countries)

        expect { subject }.to raise_error Exceptions::AppExceptions::ApiError
      end
    end
  end

  describe '#get_currencies' do
    let(:name) { double }
    let(:symbol) { double }
    let(:value) { {currencyName: name, currencySymbol: symbol} }
    let(:results) { {USD: value}.with_indifferent_access }
    let(:response) { double(success: true, body: {results: results}) }
    subject { store.get_currencies }

    before :each do
      expect(client).to receive(:get_currencies) { response }
    end

    context 'response - success' do
      it 'should return currencies' do
        values = {code: 'USD', name: name, symbol: symbol}
        expect(store).to receive(:build_currencies).with(results).and_call_original
        expect(Domains::Currency::Currency).to receive(:new).with(values) { 'Currency' }

        expect(subject).to match_array ['Currency']
      end
    end

    context 'response - error' do
      let(:response) { double(success: false, body: {error: nil}) }
      it 'should raise an error when response is not success' do
        expect(store).not_to receive(:build_currencies)

        expect { subject }.to raise_error Exceptions::AppExceptions::ApiError
      end
    end
  end

  describe '#get_exchange_rate' do
    let(:from) { double }
    let(:to) { double }
    let(:exchange_rate) { double('value') }
    let(:results) { {k: exchange_rate} }
    let(:response) { double(success: true, body: {results: results}) }
    subject { store.get_exchange_rate(from: from, to: to) }

    before :each do
      expect(client).to receive(:get_exchange_rate).with(from: from, to: to) { response }
    end

    context 'response - success' do
      it 'should return exchange_rate' do
        expect(store).to receive(:build_exchange_rate).with(exchange_rate).and_call_original
        expect(Domains::Currency::ExchangeRate).to receive(:new).with(exchange_rate) { 'Exchange Rate' }

        expect(subject).to eq 'Exchange Rate'
      end
    end

    context 'response - error' do
      let(:response) { double(success: false, body: {error: nil}) }
      it 'should raise an error when response is not success' do
        expect(store).not_to receive(:build_exchange_rate)

        expect { subject }.to raise_error Exceptions::AppExceptions::ApiError
      end
    end
  end

  describe '#get_exchange_rate_on_pairs' do
    let(:pairs_string) { double }
    let(:exchange_rate) { double }
    let(:results) { {k: exchange_rate} }
    let(:response) { double(success: true, body: {results: results}) }
    subject { store.get_exchange_rate_on_pairs(pairs_string) }

    before :each do
      expect(client).to receive(:get_exchange_rate_on_pairs).with(pairs_string) { response }
    end

    context 'response - success' do
      it 'should return exchange_rate pairs' do
        expect(store).to receive(:build_exchange_rate_on_pairs).with([exchange_rate]).and_call_original
        expect(Domains::Currency::ExchangeRate).to receive(:new).with(exchange_rate) { 'Exchange Rate' }

        expect(subject).to match_array ['Exchange Rate']
      end
    end

    context 'response - error' do
      let(:response) { double(success: false, body: {error: nil}) }
      it 'should raise an error when response is not success' do
        expect(store).not_to receive(:build_exchange_rate_on_pairs).with(response).and_call_original

        expect { subject }.to raise_error Exceptions::AppExceptions::ApiError
      end
    end
  end

  describe '#get_history' do
    let(:args) { double }
    let(:history) { double }
    let(:results) { {k: history} }
    let(:response) { double(success: true, body: {results: results}) }
    subject { store.get_history(args) }

    before :each do
      expect(client).to receive(:get_history).with(args) { response }
    end

    context 'response - success' do
      it 'should return history' do
        expect(store).to receive(:build_history_response).with(history).and_call_original
        expect(Domains::Currency::HistoryResponse).to receive(:new).with(history) { 'history' }

        expect(subject).to eq 'history'
      end
    end

    context 'response - error' do
      let(:response) { double(success: false, body: {error: nil}) }
      it 'should raise an error when response is not success' do
        expect(store).not_to receive(:build_history_response)

        expect { subject }.to raise_error Exceptions::AppExceptions::ApiError
      end
    end
  end
end

