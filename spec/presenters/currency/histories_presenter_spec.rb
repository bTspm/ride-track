require 'spec_helper'

describe Presenters::Currency::HistoriesPresenter do

  let(:view_context) { ActionController::Base.new }
  let(:locals) { {} }
  let(:rate) { 50.999999 }
  let(:date) { Date.new(2019, 01, 01) }

  let(:history) do
    double(
      rate: rate,
      date: date,
      )
  end

  describe '.scalar' do
    subject(:scalar) { described_class.present(history, view_context, locals) }

    describe '#rounded_amount' do
      subject { scalar.rounded_amount }

      it { is_expected.to eq 51.0 }
    end

    describe '#readable_date' do
      subject { scalar.readable_date }

      it { is_expected.to eq 'January 01, 2019' }
    end
  end

  describe '.enum' do
    let(:rate1) { 100 }
    let(:date1) { Date.new(9999, 12, 01) }

    let(:history1) do
      double(
        rate: rate1,
        date: date1,
        )
    end
    let(:histories) { [history, history1] }
    subject(:enum) { described_class.present(histories, view_context, locals) }

    describe '#average' do
      subject { enum.average }

      it { is_expected.to eq 75.5 }
    end

    describe '#change_difference' do
      subject { enum.change_difference }

      it { is_expected.to eq -49.0 }
    end

    describe '#change_percent' do
      subject { enum.change_percent }

      it { is_expected.to eq -96.07844 }
    end

    describe '#highest' do
      subject { enum.highest }

      it { is_expected.to eq '100 on December 01, 9999' }
    end

    describe '#lowest' do
      subject { enum.lowest }

      it { is_expected.to eq '51.0 on January 01, 2019' }
    end

    describe '#sort_by_date' do
      let(:result_array) { [date, date1] }
      subject { enum.sort_by_date.map(&:date) }

      it { is_expected.to match_array result_array }
    end

    describe '#sort_by_rate' do
      let(:result_array) { [rate, rate1] }
      subject(:array_of_sorted_rates) { enum.sort_by_rate.map(&:rate) }

      it { is_expected.to match_array result_array }
    end

    describe '#start_date' do
      subject { enum.start_date }

      it { is_expected.to eq 'January 01, 2019' }
    end

    describe '#end_date' do
      subject { enum.end_date }

      it { is_expected.to eq 'December 01, 9999' }
    end
  end
end

