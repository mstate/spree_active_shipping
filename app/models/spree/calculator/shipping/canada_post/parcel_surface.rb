module Spree
  module Calculator::Shipping
    module CanadaPost
      class ParcelSurface < Spree::Calculator::Shipping::CanadaPost::Base
        def self.description
          I18n.t("canada_post.parcel_surface")
        end
        def self.service_code
          "DOM.RP"
        end

        protected
        def max_weight_for_country(country)
        	# service not valid for Canada and US.
          return 10**100 unless country.iso == ['CA','US'].include?(country.iso)
        end      
      end
    end
  end
end
