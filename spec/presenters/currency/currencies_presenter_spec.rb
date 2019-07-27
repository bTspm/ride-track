require 'spec_helper'

describe Presenters::Currency::CurrenciesPresenter do

  let(:view_context) { ActionController::Base.new }
  let(:locals) { {} }
  let(:code) { 'USD' }
  let(:name) { 'United States Dollar' }

  let(:currency) do
    double(
      code: code,
      name: name,
    )
  end

  describe '.scalar' do
    subject(:scalar) { described_class.present(currency, view_context, locals) }

    describe '#name_with_code' do
      subject { scalar.name_with_code }
      it 'should return code with formatted name' do
        expect(scalar).to receive(:formatted_name) { 'Formatted Name' }

        expect(subject).to eq 'Formatted Name (USD)'
      end
    end

    describe '#formatted_name' do
      subject { scalar.formatted_name }

      it { is_expected.to eq 'United States Dollar' }
    end

    describe '#code_downcase' do
      subject { scalar.code_downcase }

      context 'without code' do
        let(:code) { nil }
        it { is_expected.to eq '' }
      end

      context 'with code' do
        it { is_expected.to eq 'usd' }
      end
    end
  end

  describe '.enum' do
    let(:currency1) do
      double(
        name: 'Indian Rupee',
        code: 'INR'
      )
    end
    let(:currencies) { [currency, currency1] }
    subject(:enum) { described_class.present(currencies, view_context, locals) }

    describe '#grouped_and_sorted_by_code' do
      let(:result_array) { [['I', [currency1]], ['U', [currency]]] }
      subject { enum.grouped_and_sorted_by_code }

      it { is_expected.to match_array result_array }
    end
  end
end

