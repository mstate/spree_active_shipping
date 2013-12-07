module Spree
  module Calculator::Shipping
    module CanadaPost
      class Xpresspost < Spree::Calculator::Shipping::CanadaPost::Base
        def self.description
          I18n.t("canada_post.xpresspost")
        end
        def self.service_code
          "DOM.XP"
        end

        protected
        def max_weight_for_country(country)
        	# service not valid for Canada and US.
          return 30.0 * 1000 if country.iso == 'CA'
        end      
      end
    end
  end
end
