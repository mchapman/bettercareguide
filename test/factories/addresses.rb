require 'factory_girl'

Factory.define(:address) do |a|
  a.sequence(:line1) {|n| "#{n} High Street"}
  a.city "Anytown"
  a.postal_zip_code "TN22 4EA"
  a.lat 51
  a.lng 0.127
  a.address_type_id 1
  a.association :country
end
