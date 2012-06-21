class Permission < ActiveRecord::Base
  belongs_to :service
  belongs_to :organisation
  belongs_to :user

  attr_accessible :service, :user, :is_owner, :notes, :notify_poor_ratings, :email_all_ratings, :accepted, :access_code, :notify_good_care_reviews

  scope :outstanding_access_codes, lambda { |user|
    start = (Time.now - 2.weeks).to_a; where(%[coalesce(accepted,'f') = 'f' and "permissions"."created_at" >= ? and access_code is not null and user_id = ? and coalesce(code_failures,0) < 3], Time.gm(start[5],start[4],start[3]), user.id) }

  scope :my_managed_services, lambda { |user|
    where("accepted = ? and coalesce(obsolete,'f') = 'f' and user_id = ?", true, user.id) }

  scope :service_owners_to_inform, lambda { |service|
    where("service_id = ? and coalesce(obsolete,'f') = 'f' and email_all_ratings = ?", service.id, true)
  }

  scope :service_owners_to_inform_good_care_guide, lambda { |service_id|
    where("service_id = ? and coalesce(obsolete,'f') = 'f' and notify_good_care_guide_reviews = ?", service_id, true)
  }

  scope :service_owners_to_respond, lambda { |service|
    where("service_id = ? and coalesce(obsolete,'f') = 'f' and notify_poor_ratings = ?", service.id, true)
  }

  scope :sort_by_name, joins('left outer join organisations org1 on permissions.organisation_id = org1.id left outer join services on service_id = services.id left outer join organisations org2 on org2.id = services.organisation_id').order('coalesce(org1.name,org2.name)')

  def email
    user.email
  end

  def Permission.for_output(relation)
    relation.joins(:service)
  end

  # Called user requests ownership and email domains and org urls match up
  def Permission.auto_assign_service_ownership_to_user(service,user)
    Permission.create(
      :service => service,
      :user => user,
      :is_owner => true,
      :notes => 'Auto accepted',
      :notify_poor_ratings => true,
      :email_all_ratings => true,
      :accepted => true)
  end

  def Permission.generate_access_code(service,user)
    Permission.create(
      :service => service,
      :user => user,
      :is_owner => true,
      :notify_poor_ratings => true,
      :email_all_ratings => true,
      :accepted => false,
      :access_code => rand(99999))
  end

end
