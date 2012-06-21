require 'factory_girl'

Factory.define(:organisation) do |o|
  o.sequence(:name) {|n| "Organisation #{n}"}
  o.sequence(:url) {|n| "www.organisation{#n}.co.uk"}
  o.after_create { |org| Factory.create(:address, {:organisation_id => org.id}); Factory.create(:phone, {:organisation_id => org.id}) ; Factory.create(:phone, {:organisation_id => org.id, :phone_type_id => 2}) }
end
