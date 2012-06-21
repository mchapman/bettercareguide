require 'factory_girl'

Factory.define(:rating) do |r|
  r.stars 5
  r.comments "Jolly good show"
end

