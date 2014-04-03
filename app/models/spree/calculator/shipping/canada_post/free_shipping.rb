module Spree
  module Calculator::Shipping
    module CanadaPost
      class FreeShipping #< Spree::Calculator::Shipping::CanadaPost::Base
        preference :minimal_amount, :decimal, default: 100
        preference :exclude_zip_containing, :decimal, default: 100

        def self.description
          I18n.t("canada_post.free_shipping")
        end

        def self.service_code
          "DOM.EP"
        end

        def available?(package)
          !compute(package).nil?
        rescue Spree::ShippingError
          false
        end
        def compute_package(package)
          order = package.order
          destination = build_location(order.ship_address)
          return nil if !Spree::ActiveShipping::Config[:exclude_postal_codes_containing.blank? && !(destination.zip =~ /#{Spree::ActiveShipping::Config[:exclude_postal_codes_containing]}/)
          return nil if order.total >= Spree::ActiveShipping::Config[:minimum_value_for_free_shipping].to_f
          return 0.0
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