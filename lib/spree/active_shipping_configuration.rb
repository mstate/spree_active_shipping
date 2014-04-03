class Spree::ActiveShippingConfiguration < Spree::Preferences::Configuration

  preference :ups_login, :string, :default => "aunt_judy"
  preference :ups_password, :string, :default => "secret"
  preference :ups_key, :string, :default => "developer_key"
  preference :shipper_number, :string, :default => nil

  preference :fedex_login, :string, :default => "meter_no"
  preference :fedex_password, :string, :default => "special_sha1_looking_thing_sent_via_email"
  preference :fedex_account, :string, :default => "account_no"
  preference :fedex_key, :string, :default => "authorization_key"

  preference :usps_login, :string, :default => "aunt_judy"

  preference :canada_post_key, :string, :default => "canada_post_key"
  preference :canada_post_key_password, :string, :default => "canada_post_key_password"
  preference :canada_post_customer_number, :string
  preference :canada_post_contract_number, :string

  preference :origin_sender, :string, :default => "Your Company Name"
  preference :origin_address1, :string, :default => "123 My Street"
  preference :origin_address2, :string
  preference :origin_state, :string, :default => "ON"
  preference :origin_city, :string, :default => "Concord"
  preference :origin_zip, :string, :default => "L4K1G6"
  preference :origin_country, :string, :default => "CA"

  preference :units, :string, :default => "metric"
  preference :unit_multiplier, :integer, :default => 0 # 16 oz./lb - assumes variant weights are in lbs
  preference :default_weight, :integer, :default => 0 # 16 oz./lb - assumes variant weights are in lbs
  preference :handling_fee, :integer
  preference :max_weight_per_package, :integer, :default => 0 # 0 means no limit

  preference :test_mode, :boolean, :default => false

  preference :minimum_value_for_free_shipping, :integer, :default => 100
end
