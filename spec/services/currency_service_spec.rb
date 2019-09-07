require 'spec_helper'

describe Services::CurrencyService do

  let(:currency) { double('currency', name: 'ABC', code: 'ABC') }
  let(:currency1) { double('currency2', name: 'XYZ', code: 'XYZ') }
  let(:currencies) { [currency, currency1] }
  let(:currency_store) { double('currency_store') }
  let(:ip_store) { double('ip_store') }

  subject(:service) { Services::CurrencyService.new }

  describe '#get_currencies' do
    subject { service.get_currencies }

    it 'should expect to call currency storage' do
      expect(service).to receive(:_currencies).and_call_original
      expect(service).to receive(:currency_storage) { currency_store }
      expect(currency_store).to receive(:get_currencies) { currencies }

      expect(subject.map(&:name)).to match_array %w(ABC XYZ)
    end
  end

  describe '#get_currencies_from_ip' do
    let(:address) { double('address', currency_code: currency_code) }
    let(:currency_code) { 'INR' }
    let(:ip_detail) { double('ip_detail', address: address) }
    let(:ip) { double('ip') }

    subject { service.get_currencies_from_ip(ip) }

    before :each do
      expect(service).to receive(:ip_storage) { ip_store }
      expect(service).to receive(:_get_local_currency_from_ip).with(ip).and_call_original
    end

    context 'currency from IP - USD' do
      let(:currency_code) { 'USD' }
      it 'should return hash with to anf from currencies' do
        expect(ip_store).to receive(:get_ip_details).with(ip) { ip_detail }

        expect(subject).to eq({from: 'USD', to: 'GBP'})
      end
    end

    context 'currency from IP - non USD' do
      it 'should return hash with to anf from currencies' do
        expect(ip_store).to receive(:get_ip_details).with(ip) { ip_detail }

        expect(subject).to eq({from: 'USD', to: 'INR'})
      end
    end

    context 'no currency' do
      let(:currency_code) { nil }
      it 'should return hash with to anf from currencies' do
        expect(ip_store).to receive(:get_ip_details).with(ip) { ip_detail }

        expect(subject).to eq({from: 'USD', to: 'GBP'})
      end
    end

    context 'when ip call fails' do
      let(:exception) { Exceptions::AppExceptions::ApiError.new(message: '') }
      it 'should return hash with to anf from currencies' do
        expect(ip_store).to receive(:get_ip_details).with(ip).and_raise(exception)

        expect(subject).to eq({from: 'USD', to: 'GBP'})
      end
    end
  end

  describe '#get_currency_histories' do
    let(:args) do
      {
        to: to,
        from: from,
        start_date: start_date,
        end_date: end_date
      }
    end
    let(:history_args) { args }
    let(:to) { double('to') }
    let(:from) { double('from') }
    let(:start_date) { double('start_date') }
    let(:end_date) { double('end_date') }
    subject { service.get_currency_histories(args) }

    before :each do
      expect(service).to receive(:_history_date_args).with(args).and_call_original
      expect(service).to receive(:currency_storage) { currency_store }
      expect(currency_store).to receive(:get_history).with(history_args) { 'History' }
    end

    context 'with date args' do
      it { is_expected.to eq 'History' }
    end

    context 'with no date args' do
      let(:start_date) { nil }
      let(:end_date) { nil }
      let(:history_args) do
        {
          to: to,
          from: from,
          start_date: (Date.today - 8.days),
          end_date: Date.today
        }
      end

      it { is_expected.to eq 'History' }
    end
  end

  describe '#get_exchange_rate' do
    let(:to) { double('to') }
    let(:from) { double('from') }
    subject { service.get_exchange_rate(from: from, to: to) }

    it 'should expect to call currency storage' do
      expect(service).to receive(:currency_storage) { currency_store }
      expect(currency_store).to receive(:get_exchange_rate).with(from: from, to: to) { 'Exchange rate' }

      expect(subject).to eq 'Exchange rate'
    end
  end

  describe '#get_exchange_rate_with_currency_details' do
    let(:to) { 'USD' }
    let(:from) { 'INR' }
    let(:country) { double('country', name: 'ABC', currency: currency) }
    let(:country1) { double('country2', name: 'XYZ', currency: currency1) }
    let(:countries) { [country, country1] }
    let(:currency) { OpenStruct.new(name: 'United States Dollar', code: 'USD', countries: nil) }
    let(:currency1) { OpenStruct.new(name: 'Indian Rupee', code: 'INR', countries: nil) }
    let(:currencies) { [currency, currency1] }

    let(:exchange_rate) do
      OpenStruct.new(
        from_currency: nil,
        to_currency: nil,
        to: to,
        from: from
      )
    end
    subject { service.get_exchange_rate_with_currency_details(from: from, to: to) }

    before :each do
      expect(service).to receive(:get_exchange_rate).with(from: from, to: to) { exchange_rate }
      expect(service).to receive(:_currencies).exactly(2).times { currencies }
      expect(service).to receive(:_countries).and_call_original
      expect(service).to receive(:currency_storage) { currency_store }
      expect(currency_store).to receive(:get_countries_with_currencies) { countries }
      expect(service).to receive(:_get_countries_by_currency).exactly(2).times.and_call_original
    end

    it 'should return exchange rate with from and to country' do
      exchange_rate = subject
      expect(exchange_rate.from_currency).to eq currency1
      expect(exchange_rate.to_currency).to eq currency
    end
  end

  describe '#get_popular_currency_exchanges' do
    let(:from) { 'INR' }
    let(:pairs) { ['pairs'] }
    subject { service.get_popular_currency_exchanges(from) }

    before :each do
      expect(service).to receive(:_currency_pairs).with(from).and_call_original
      expect(service).to receive(:currency_storage) { currency_store }
      expect(currency_store).to receive(:get_exchange_rate_on_pairs).with(currency_pairs) { pairs }
    end

    context 'with one of default currencies' do
      let(:currency_pairs) { 'INR_USD,USD_INR,INR_EUR,EUR_INR,INR_GBP,GBP_INR,INR_JPY,JPY_INR' }

      it { is_expected.to match_array pairs }
    end

    context 'not a default currency' do
      let(:from) { 'ABC' }
      let(:currency_pairs) { 'ABC_USD,USD_ABC,ABC_INR,INR_ABC,ABC_EUR,EUR_ABC,ABC_GBP,GBP_ABC,ABC_JPY,JPY_ABC' }

      it { is_expected.to match_array pairs }
    end
  end
end

