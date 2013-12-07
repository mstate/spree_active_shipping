require_dependency 'spree/calculator'

module Spree
  module Calculator::Shipping
    module CanadaPost
      class Base < Spree::Calculator::Shipping::ActiveShipping::Base
        def carrier
          # canada_post_options[:endpoint] = 'https://ct.soa-gw.canadapost.ca/' unless Rails.env == 'production'
          ActiveMerchant::Shipping::CanadaPostPWS.new(carrier_details)
        end
        def carrier_details 
          {
            :api_key  => Spree::ActiveShipping::Config[:canada_post_key],
            :secret  => Spree::ActiveShipping::Config[:canada_post_key_password],
            :customer_number =>  Spree::ActiveShipping::Config[:canada_post_customer_number],
            :french => (I18n.locale.to_sym == :fr)
          }
        end
        def country_weight_error? package
          max_weight = max_weight_for_country(package.order.ship_address.country)
          raise Spree::ShippingError.new("#{I18n.t(:shipping_error)}: The maximum per package weight for the selected service from the selected country is #{max_weight} ounces.") unless valid_weight_for_package?(package, max_weight)
        end

        def retrieve_rates(origin, destination, shipment_packages)
          begin
            response = carrier.find_rates(origin, destination, shipment_packages, carrier_details, shipment_packages.first)
            # turn this beastly array into a nice little hash
            rates = response.rates.collect do |rate|
              service_code = rate.service_code
              [service_code, rate.price]
            end
            rate_hash = Hash[*rates.flatten]
            return rate_hash
          rescue ActiveMerchant::ActiveMerchantError => e

            if [ActiveMerchant::ResponseError, ActiveMerchant::Shipping::ResponseError].include?(e.class) && e.response.is_a?(ActiveMerchant::Shipping::Response)
              params = e.response.params
              if params.has_key?("Response") && params["Response"].has_key?("Error") && params["Response"]["Error"].has_key?("ErrorDescription")
                message = params["Response"]["Error"]["ErrorDescription"]
              # Canada Post specific error message
              elsif params.has_key?("eparcel") && params["eparcel"].has_key?("error") && params["eparcel"]["error"].has_key?("statusMessage")
                message = e.response.params["eparcel"]["error"]["statusMessage"]
              else
                message = e.message
              end
            else
              message = e.message
            end

            error = Spree::ShippingError.new("#{I18n.t(:shipping_error)}: #{message}")
            Rails.cache.write @cache_key, error #write error to cache to prevent constant re-lookups
            raise error
          end

        end
      end
    end
  end
end
