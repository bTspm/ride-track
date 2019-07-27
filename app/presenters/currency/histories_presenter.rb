module Presenters::Currency
  class HistoriesPresenter
    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter

      def rounded_amount
        rate.round(5)
      end

      def readable_date
        date.strftime('%B %d, %Y')
      end
    end

    class Enum < Btspm::Presenters::EnumPresenter

      def average
        (sum(&:rate) / length).round(5)
      end

      def change_difference
        (sort_by_date.first.rounded_amount - sort_by_date.last.rounded_amount).round(5)
      end

      def change_percent
        diff = sort_by_date.first.rate - sort_by_date.last.rate
        ((diff / sort_by_date.first.rate) * 100.00).round(5)
      end

      def highest
        history = sort_by_rate.last
        "#{history.rounded_amount} on #{history.readable_date}"
      end

      def lowest
        history = sort_by_rate.first
        "#{history.rounded_amount} on #{history.readable_date}"
      end

      def sort_by_date
        sort_by(&:date)
      end

      def sort_by_rate
        sort_by(&:rate)
      end

      def start_date
        sort_by_date.first.readable_date
      end

      def end_date
        sort_by_date.last.readable_date
      end
    end
  end
end

