module Services
  class IpService < BusinessService
    include Services

    def get_ip_details(ip_or_domain)
      ip_storage.get_ip_details(ip_or_domain)
    end

    def get_ip_quality_details(ip)
      ip_quality_storage.get_ip_quality_details(ip)
    end
  end
end

