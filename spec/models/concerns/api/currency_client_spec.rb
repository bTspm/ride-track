require 'spec_helper'

describe Api::CurrencyClient do

  let(:expire_time) { 100 }
  let(:key) { double }
  let(:params) { {url: url, cache_key: cache_key, expire_time: expire_time} }
  let(:version) { double }

  subject(:client) { Api::CurrencyClient.new }

  describe '#initialize' do
    it { is_expected.to be_a_kind_of Api::CurrencyClient }
  end

  describe '#get_countries_with_currencies' do
    let(:cache_key) { 'countries' }
    let(:url) { "#{version}/countries?apiKey=#{key}" }

    subject { client.get_countries_with_currencies }

    it 'should expect to call get with url' do
      expect(client).to receive(:key) { key }
      expect(client).to receive(:version) { version }
      expect(client).to receive(:get).with(params) { 'Countries with Currencies' }
      stub_const('Api::CacheTime::ONE_DAY', expire_time)

      expect(subject).to eq 'Countries with Currencies'
    end
  end

  describe '#get_currencies' do
    let(:cache_key) { 'currencies' }
    let(:url) { "#{version}/currencies?apiKey=#{key}" }

    subject { client.get_currencies }

    it 'should expect to call get with url' do
      expect(client).to receive(:key) { key }
      expect(client).to receive(:version) { version }
      expect(client).to receive(:get).with(params) { 'Currencies' }
      stub_const('Api::CacheTime::ONE_DAY', expire_time)

      expect(subject).to eq 'Currencies'
    end
  end

  describe '#get_exchange_rate' do
    let(:cache_key) { "exchange_rate-#{from}-#{to}" }
    let(:expire_time) { 100 }
    let(:from) { double }
    let(:key) { double }
    let(:to) { double }
    let(:url) { "#{version}/convert?q=#{from}_#{to}&apiKey=#{key}" }
    let(:version) { double }

    subject { client.get_exchange_rate(from: from, to: to) }

    it 'should expect to call get with url' do
      expect(client).to receive(:key) { key }
      expect(client).to receive(:version) { version }
      expect(client).to receive(:get).with(params) { 'Exchange rate' }
      expect_any_instance_of(Api::CacheTime).to receive(:calc_top_of_hour) { expire_time }

      expect(subject).to eq 'Exchange rate'
    end
  end

  describe '#get_exchange_rate_on_pairs' do
    let(:cache_key) { "pairs-#{pairs_string}" }
    let(:expire_time) { 100 }
    let(:pairs_string) { double }
    let(:url) { "#{version}/convert?q=#{pairs_string}&apiKey=#{key}" }
    let(:version) { double }

    subject { client.get_exchange_rate_on_pairs(pairs_string) }

    it 'should expect to call get with url' do
      expect(client).to receive(:key) { key }
      expect(client).to receive(:version) { version }
      expect(client).to receive(:get).with(params) { 'Exchange rate on pairs' }
      expect_any_instance_of(Api::CacheTime).to receive(:calc_top_of_hour) { expire_time }

      expect(subject).to eq 'Exchange rate on pairs'
    end
  end

  describe '#get_history' do
    let(:args) do
      {
        from: from,
        to: to,
        start_date: start_date,
        end_date: end_date
      }
    end
    let(:from) { double }
    let(:to) { double }
    let(:start_date) { double }
    let(:end_date) { double }
    let(:cache_key) { "history-#{args[:from]}-#{args[:to]}-#{args[:start_date]}-#{args[:end_date]}" }
    let(:expire_time) { 100 }
    let(:url) do
      url = "#{version}/convert?q=#{args[:from]}_#{args[:to]}"
      url += "&date=#{args[:start_date]}&endDate=#{args[:end_date]}&apiKey=#{key}"
      url
    end
    let(:version) { double }

    subject { client.get_history(args) }

    it 'should expect to call get with url' do
      expect(client).to receive(:key) { key }
      expect(client).to receive(:version) { version }
      expect(client).to receive(:get).with(params) { 'History' }
      stub_const('Api::CacheTime::ONE_DAY', expire_time)

      expect(subject).to eq 'History'
    end
  end
end

