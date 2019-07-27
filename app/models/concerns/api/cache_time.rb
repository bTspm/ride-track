module Api
  module CacheTime
    ONE_DAY = 86_400
    ONE_HOUR = 3_600
    ONE_MINUTE = 60

    def calc_top_of_hour
      time_now = _time_now
      (ONE_HOUR - (time_now - time_now.beginning_of_hour)).ceil(0)
    end

    private

    def _time_now
      Time.now.utc
    end
  end
end

