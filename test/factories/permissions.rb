require 'factory_girl'

Factory.define(:permission) do |p|
  p.is_owner  "true" 
  p.access_code  "12345" 
  p.code_failures  "0" 
  p.accepted  "false" 
end
