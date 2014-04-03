module Spree
  module Calculator::Shipping
    module CanadaPost
      class FreeExpeditedShipping < Spree::Calculator::Shipping::CanadaPost::Base
        preference :minimum_line_item_total_amount, :decimal, :default => 100
        preference :maximum_shipping_cost, :decimal, :default => 14

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
          return nil if order.item_total < self.preferred_minimum_line_item_total_amount.to_f
          return nil if !self.preferred_maximum_shipping_cost.blank? && 
            self.preferred_maximum_shipping_cost > Spree::Calculator::Shipping::CanadaPost::Expedited.new.compute(package)
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