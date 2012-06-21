require 'factory_girl'

Factory.define(:user) do |u|
  u.sequence(:email) {|n| "anyone#{n}@example.com"}
  u.password "secret"
  u.password_confirmation {|a| "#{a.password}" }
  u.confirmed_at "01 Jan 2010"
  u.roles_mask "0"
end
