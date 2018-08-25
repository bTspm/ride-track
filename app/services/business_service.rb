module Services
  class BusinessService

    def initialize(engine: nil)
      @engine = engine
    end

    def engine
      #FakeStorage can be initialized for tests.
      @engine ||= ::Storage::Allocator.new
    end

    def uber_storage
      engine.uber_store
    end

    def lyft_storage
      engine.lyft_store
    end

  end
end