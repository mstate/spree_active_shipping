module Spree
  module Calculator::Shipping
    module CanadaPost
      class XpresspostInternational < Spree::Calculator::Shipping::CanadaPost::Base
        def self.description
          I18n.t("canada_post.xpresspost_international")
        end
        def self.service_code
          "INT.XP"
        end

        protected
        def max_weight_for_country(country)
        	# service not valid for Canada and US.
          return 20.0 * 1000 unless country.iso == ['CA','US'].include?(country.iso)
        end      
      end
    end
  end
end
