class Person < ActiveRecord::Base
  validates :family_name, :presence => true
  has_many :ownerships
  has_many :employments
  has_many :addresses
  has_many :phones
  belongs_to :user

  attr_accessible :family_name, :given_name, :user_id, :user

  def full_name
    given_name + ' ' + family_name
  end

end
