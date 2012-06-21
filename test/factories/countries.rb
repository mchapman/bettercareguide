require 'factory_girl'

Factory.define(:country) do |c|
  c.sequence(:name) {|n| "Country#{n}"}
end
