require 'factory_girl'

Factory.define(:address_type) do |a|
  a.sequence(:description) {|n| "Address type #{n}"}
end
