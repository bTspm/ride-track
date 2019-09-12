module Services
  class BusinessService

    def initialize(engine: nil)
      @engine = engine
    end

    def engine
      #FakeStorage can be initialized for tests.
      @engine ||= ::Storage::Allocator.new
    end

    #Stores
    def currency_storage
      engine.currency_store
    end

    def ip_quality_storage
      engine.ip_quality_store
    end

    def ip_storage
      engine.ip_store
    end

    def lyft_storage
      engine.lyft_store
    end

    def uber_storage
      engine.uber_store
    end
  end
end

