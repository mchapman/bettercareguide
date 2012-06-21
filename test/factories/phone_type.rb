require 'factory_girl'

Factory.define(:phone_type) do |p|
  p.sequence(:description) {|n| "Phone type #{n}"}
end
