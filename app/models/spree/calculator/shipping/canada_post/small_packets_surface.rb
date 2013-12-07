module Spree
  module Calculator::Shipping
    module CanadaPost
      class SmallPacketsSurface < Spree::Calculator::Shipping::CanadaPost::Base
        def self.description
          I18n.t("canada_post.small_packets_surface")
        end
      end
      def self.service_code
        "INT.SP.SURF"
      end

      protected
      def max_weight_for_country(country)
      	# service not valid for Canada and US.
        return 2.0 * 1000 unless country.iso == ['CA','US'].include?(country.iso)
      end      
    end
  end
end
