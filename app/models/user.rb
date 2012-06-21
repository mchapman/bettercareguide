class User < ActiveRecord::Base
  PASSWORD_WORDS = ['apple','banana','cruncy','dairy','elvis','franky','george',
    'holiday','igloo','junk','kanji','lemon','monkey','nails','opera','poster','quell',
    'roaming','sherry','tiger','unite','vincent','whale','xenon','yellow','zoom']

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :terms_and_conditions, :presence => { :message => 'must be accepted before you can proceed' }

  attr_accessor :initial_password
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :initial_password, :accepted_t_and_cs

  has_one :person
  has_many :permissions

  ROLES = %w[admin reallycare]
  scope :with_role, lambda { |role| where("roles_mask & ? > 0 ", 2**ROLES.index(role.to_s))}

  after_save(:on => :update) do
    # If the user has just been confirmed then see if they have any ratings that now need to be published
    # Would prefer this to be an after_commit, but cucumber doesn't appear to work when it is
    if self.confirmed_at
      Rating::release_ratings_after_user_confirmation(self.id) if self.confirmed_at > (self.updated_at - 1.minute)
    end
  end

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def role_symbols
    roles.map(&:to_sym)
  end

  def accepted_t_and_cs
    terms_and_conditions != nil
  end

  def accepted_t_and_cs=(value)
    if value == "1"
      self.terms_and_conditions = Time.now
    else
      self.terms_and_conditions = nil
    end
  end

  def role? role
    roles.include? role.to_s  
  end

  def set_menu_text(relation,singular)
    if relation.empty?
      ''
    elsif relation.count == 1
      singular
    else
      singular + 's'    # No support for irregular plurals here
    end
  end

  def managed_service
    set_menu_text(Permission.my_managed_services(self),'My Service')
  end

  def access_opt
    set_menu_text(Permission.outstanding_access_codes(self),'Access Code')
  end

  def User.create_with_password(email, accepted_t_and_cs = false)
    random_password = PASSWORD_WORDS[rand(26)]+(rand(999).to_s)
    create(:email => email, :password => random_password, :initial_password => random_password, :accepted_t_and_cs => accepted_t_and_cs)
  end

  def full_name(default)
    person = Person.find_by_user_id(id)
    if person
      person.full_name
    elsif default == :email
      email
    else
      default
    end
  end

end
