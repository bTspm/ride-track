module Storage
  class Allocator

    def uber_store
      Storage::RideTrack::UberStore.new
    end

    def lyft_store
      Storage::RideTrack::LyftStore.new
    end

  end
end