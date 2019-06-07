module Presenters::Currency
  class HistoryResponsePresenter
    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter

      def histories
        @histories_presenter ||= ::Presenters::Currency::HistoriesPresenter.present(data_object.histories, h)
      end

      def chart_data
        {rates: histories.map(&:rate), dates:  histories.map(&:date), label: _label}.to_json
      end

      private

      def _label
        "#{from} to #{to}"
      end
    end
  end
end

