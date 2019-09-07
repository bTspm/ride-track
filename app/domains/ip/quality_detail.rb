module Domains::Ip
  class QualityDetail
    attr_reader :bot_status,
                :fraud_score,
                :is_crawler,
                :mobile,
                :proxy,
                :recent_abuse,
                :tor,
                :vpn

    def initialize(response = {})
      @response = (response || {}).with_indifferent_access
      @bot_status = response[:bot_status]
      @fraud_score = response[:fraud_score].to_i
      @is_crawler = response[:is_crawler]
      @mobile = response[:mobile]
      @proxy = response[:proxy]
      @recent_abuse = response[:recent_abuse]
      @tor = response[:tor]
      @vpn = response[:vpn]
    end
  end
end

