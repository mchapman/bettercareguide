class Ownership < ActiveRecord::Base
  belongs_to :organisation
  belongs_to :owning_organisation, :class_name => 'Organisation'
  belongs_to :person
  belongs_to :ownership_type
end
