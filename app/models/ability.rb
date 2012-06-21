  class Ability
    include CanCan::Ability

    def initialize(user)
      can [:search, :home, :show, :claim], Service
      can [:preview, :amend, :publish, :abandon, :modify], Rating do |rating, remote_ip|
        rating &&
        rating.has_status(:preview_only) &&
        ((user && user.id == rating.rater_id) || (user.nil? && remote_ip == rating.creation_ip_address))
      end
      if user
        can :mydashboard, User
        if user.role?(:admin)
          can :manage, :all
          can :dashboard, User
          cannot [:claim, :admin], Service
          cannot [:respond], Rating
        elsif user.role?(:reallycare)
          can :dashboard, user
          can :manage, [Service, Organisation, Address, Permission, Phone, User]
          cannot [:claim, :admin], Service
          cannot [:respond], Rating
        else
          can :dashboard, user
          can [:sendcode, :my_services], Service
          can :enter_codes, Permission
          can [:enter_code, :process_code], Permission do |permission|
            permission && Permission.outstanding_access_codes(user).reject{ |perm| perm.id != permission.id}.compact.length == 1
          end
          can :update, Service do |service|
            service && Permission.my_managed_services(user).reject{ |perm| perm.service_id != service.id}.compact.length == 1
          end
          can :admin, Service do |service|
            service && Permission.my_managed_services(user).where(:is_owner => true).reject{ |perm| perm.service_id != service.id}.compact.length == 1
          end
          can :respond, Rating do |rating|
            rating && rating.response_datetime.blank? && Permission.my_managed_services(user).reject{ |perm| perm.service_id != rating.service_id}.compact.length == 1
          end
        end
      end
    end
  end

