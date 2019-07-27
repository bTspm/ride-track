require 'spec_helper'

describe Presenters::Currency::HistoryResponsePresenter do

  let(:view_context) { ActionController::Base.new }
  let(:locals) { {} }
  let(:from) { double }
  let(:to) { double }
  let(:rate) { 'Rate' }
  let(:date) { 'Date' }
  let(:history) {
    double(
      rate: rate,
      date: date
    )
  }
  let(:histories) { [history] }
  let(:histories_presenter) { double }

  let(:history_response) do
    double(
      histories: histories,
      from: from,
      to: to
    )
  end

  describe '.scalar' do
    subject(:scalar) { described_class.present(history_response, view_context, locals) }

    describe '#histories' do
      subject { scalar.histories }
      it 'should initiate histories presenters' do
        expect(
          Presenters::Currency::HistoriesPresenter
        ).to receive(:present).with(histories, view_context) { 'Histories' }

        expect(subject).to eq 'Histories'
      end
    end

    describe '#chart_data' do
      subject { JSON.parse(scalar.chart_data).with_indifferent_access }

      it 'should return JSON with rates, dates and label' do
        expect(scalar).to receive(:_label).and_call_original
        expect(scalar).to receive(:histories).exactly(2).times { histories_presenter }
        expect(histories_presenter).to receive(:sort_by_date).exactly(2).times { histories }

        expect(subject[:rates]).to match_array [rate]
        expect(subject[:dates]).to match_array [date]
        expect(subject[:label]).to eq "#{from} to #{to}"
      end
    end
  end
end

