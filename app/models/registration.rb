class Registration < ActiveRecord::Base
  belongs_to :regulator
  belongs_to :service
  belongs_to :organisation
  belongs_to :regulator_score
  belongs_to :regulator_service_type
end