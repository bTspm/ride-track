module Storage
  class Allocator
    def uber_store
      Storage::RideTrack::UberStore.new
    end

    def lyft_store
      Storage::RideTrack::LyftStore.new
    end

    def currency_store
      Storage::Currency::CurrencyStore.new
    end

    def ip_store
      Storage::IpStore.new
    end
  end
end

