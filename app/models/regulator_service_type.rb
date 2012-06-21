class RegulatorServiceType < ActiveRecord::Base
  validates :regulator_description, :presence => true
  belongs_to :internal_service_type
  belongs_to :regulator

  after_initialize :init

  def init
    self.internal_service_type_id ||= 3
  end

end
