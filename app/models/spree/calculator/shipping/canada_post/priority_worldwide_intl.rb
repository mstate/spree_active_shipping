module Spree
  module Calculator::Shipping
    module CanadaPost
      class PriorityWorldwideIntl < Spree::Calculator::Shipping::CanadaPost::Base
        def self.description
          I18n.t("canada_post.priority_worldwide_intl")
        end
        def self.service_code
          "INT.PW.PARCEL"
        end

        protected
        def max_weight_for_country(country)
        	# service not valid for Canada and US.
          return 1.5 * 1000 unless country.iso == ['CA','US'].include?(country.iso)
        end      
      end
    end
  end
end

