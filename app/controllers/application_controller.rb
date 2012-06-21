class ApplicationController < ActionController::Base

# USERNAME, PASSWORD = "reallycare", "7761"
  REDIRECT_FROM = ['thebigcaresite.heroku.com',
                   'bettercareguide.org',
                   'www.bettercareguide.co.uk', 'bettercareguide.co.uk',
                   'www.bettercareguide.org.uk', 'bettercareguide.org.uk',
                   'www.thebigcaresite.org.uk', 'thebigcaresite.org.uk',
                   'www.thebigcaresite.info', 'thebigcaresite.info',
                   'www.thebigcaresite.org', 'thebigcaresite.org']

protect_from_forgery
before_filter :redirect

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url
  end

private

def redirect
  request_host = request.env['HTTP_HOST']
  if REDIRECT_FROM.index(request_host)
#    Rails.logger.info "REMOTE_ADDR: #{request.env['REMOTE_ADDR']}\nREMOTE_HOST #{request.env['REMOTE_HOST']}\nREQUEST_URI: #{request.env['REQUEST_URI']}\nSCRIPT_NAME: #{request.env['SCRIPT_NAME']}\nSERVER_NAME: #{request.env['SERVER_NAME']}\nSERVER_PORT: #{request.env['SERVER_PORT']}\nHTTP_HOST: #{request.env['HTTP_HOST']}\nREQUEST_PATH: #{request.env['REQUEST_PATH']}\nORIGINAL_FULLPATH: #{request.env['ORIGINAL_FULLPATH']}"
    headers["Status"] = "301 Moved Permanently"
    redirect_to "#{SITE_URL}#{request.env["ORIGINAL_FULLPATH"]}", :status => :moved_permanently
  end
  @cookie_message = cookies[:eucookie] != 'OK'
end

end