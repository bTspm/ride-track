module Presenters::Currency
  class CurrenciesPresenter
    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter

      def name_with_code
        "#{formatted_name} (#{code})"
      end

      def formatted_name
        name.split.map(&:capitalize).join(' ')
      end

      def code_downcase
        return '' if code.blank?
        code.downcase
      end
    end

    class Enum < Btspm::Presenters::EnumPresenter

      def groups
        a = nil
      end

    end
  end
end

