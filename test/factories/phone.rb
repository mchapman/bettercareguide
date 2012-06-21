require 'factory_girl'

Factory.define(:phone) do |p|
  p.sequence(:number) {|n| "0800 2322#{n}"}
  p.address_type_id 1
  p.phone_type_id 1
  p.association :country
end
