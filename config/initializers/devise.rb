Devise.setup do |config|
  config.mailer_sender = "bettercareguide@reallycare.org"
  # Load and configure the ORM. Supports :active_record (default) and
  # :mongoid (bson_ext recommended) by default. Other ORMs may be
  # available as additional gems.
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.stretches = 10
  config.encryptor = :bcrypt
  config.pepper = "d4428f99515e1c7475c1b28dd5cdca9536595e31a29a1ac6df72779afd652a2dad1c5cec260d96cf5ed1a1bc8a2ed0c2da4d5e1a50cba5993146a27b344f1cbe"
  config.reset_password_within = 6.hours
  config.use_salt_as_remember_token = true
end
