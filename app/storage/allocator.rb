module Storage
  class Allocator
    def currency_store
      Storage::CurrencyStore.new
    end

    def ip_quality_store
      Storage::IpQualityStore.new
    end

    def ip_store
      Storage::IpStore.new
    end

    def lyft_store
      Storage::RideTrack::LyftStore.new
    end

    def uber_store
      Storage::RideTrack::UberStore.new
    end
  end
end

