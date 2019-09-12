module Presenters::IpDetails
  class IpDetailsPresenter
    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter
      def address
        @address_presenter ||= ::Presenters::AddressesPresenter.present(data_object.address, h)
      end
    end
  end
end

