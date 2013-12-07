module Spree
  module Calculator::Shipping
    module CanadaPost
      class Expedited < Spree::Calculator::Shipping::CanadaPost::Base
        def self.description
          I18n.t("canada_post.expedited")
        end

        def self.service_code
          "DOM.EP"
        end

        protected
        def max_weight_for_country(country)
          # if weight in ounces > 3.5, then First Class Mail International is not available for the order
          # https://www.usps.com/ship/first-class-international.htm
          return 30 * 1000 if country.iso == 'CA'
        end
      end
   end
  end
end
