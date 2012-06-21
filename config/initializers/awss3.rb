require 'aws/s3'
AWS::S3::Base.establish_connection!( :access_key_id => ENV['S3KEY'], :secret_access_key => ENV['S3SECRET'])

