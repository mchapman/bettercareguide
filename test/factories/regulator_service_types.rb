require 'factory_girl'

Factory.define(:regulator_service_type) do |t|
  t.sequence(:regulator_description) {|n| "Regulator Service Type #{n}"}
  t.association :regulator
  t.association :internal_service_type
end
