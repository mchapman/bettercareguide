require 'string_extensions'

class Rating < ActiveRecord::Base
  belongs_to :rater, :class_name => "User"
  belongs_to :response_user, :class_name => "User"
  belongs_to :service
  belongs_to :next_rating, :class_name => "Rating"
  belongs_to :rater_type
  validates :stars, :presence => true, :numericality => true, :inclusion => {:in => 1..5}
  validates :rater_type_id, :presence => { :message => '- You must specify your relationship to the service provider' }
  validates :comments, :presence => { :message => '- You must enter a review' }, :length => { :minimum => 50 }

  attr_accessor :ip_address, :skip_publish_threshold_check
  attr_accessible :service_id, :rater_id, :status_mask, :rater_type_id, :comments, :effective_date

  STATUSES = %w[user_unconfirmed superseded withdrawn pending_service_owner preview_only pending_reallycare_approval reported_by_provider incomplete_phone needs_transcription]

  scope :with_status, lambda { |status| where("status_mask & ? > 0", Rating::status_bit(status))}
  scope :published_for_service_id, lambda { |service_id| where("service_id = ? and coalesce(status_mask,0) = 0", service_id)}

  before_update do
    if @skip_publish_threshold_check != true && (status_mask == nil or status_mask == 0)
      publish_threshold = service.invite_comment_up_to_stars
      if !publish_threshold
        publish_threshold = 0
      end
      if stars <= publish_threshold && stars > 0 and not Permission.service_owners_to_respond(service).empty?
        self.add_status(:pending_service_owner)
        self.response_required_by = Time.new + 3.days
      end
    end
    self.comments = comments.censored if comments
    self.response_text = response_text.censored if response_text
  end

  after_save do
    if (status_mask == nil or status_mask == 0)
      # Update the cached ratings on the service
      self.service.update_rate_cache
      # Email the rater to say it is published
      RatingsMsg.inform_rater_publish(self).deliver if rater_id
      # Email people the service owner wants notified
      Permission.service_owners_to_inform(service).each { |perm| RatingsMsg.inform_service_owner_publish(self, perm.user).deliver }
    end
    if has_status(:pending_service_owner)
      Permission.service_owners_to_respond(service).each { |perm| RatingsMsg.request_service_owner_comments(self, perm.user).deliver }
    end
  end

  def Rating.release_ratings_after_user_confirmation(user_id)
    Rating.with_status('user_unconfirmed').where(:rater_id => user_id).each {|r| r.remove_status('user_unconfirmed',true)}
  end

  def Rating.status_bit(status)
    return 2**STATUSES.index(status.to_s)
  end

  def has_status(status)
    if self.status_mask
      if status.instance_of? Fixnum
        this_bit = status
      else
        this_bit = Rating::status_bit(status)
      end
      has_it = (status_mask & this_bit > 0)
    else
      has_it = false
    end
    has_it
  end

  def add_status(status, save_it = false)
    this_bit = Rating::status_bit(status)
    if self.status_mask
      if (status_mask & this_bit == 0)
        self.status_mask = self.status_mask + this_bit
        self.save! if save_it
      end
    else
      self.status_mask = this_bit
      self.save! if save_it
    end
  end

  def remove_status(status, save_it = false)
    this_bit = Rating::status_bit(status)
    if self.has_status(this_bit)
      self.status_mask = self.status_mask - this_bit
      self.save! if save_it
    end
  end

  def rating_effective_from
    self.effective_date ? self.effective_date : self.created_at
  end

  def status_mask_text
    if status_mask == nil or status_mask == 0
      result = "Published"
    else
      result = ''
      conjunction = ''
      STATUSES.each do |status|
        if has_status(status)
          result = result + conjunction + status.humanize
          conjunction = ', '
        end
      end
    end
    return result
  end

end