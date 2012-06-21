module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^[the ]?home\s?page$/
      '/'
    when /register/
      '/users/sign_up'
    when /(sign|log)\s?in/
      '/users/sign_in'
    when /(the|my) profile[ page]?/
      '/users/edit'
    when /[the ]?import[ page]?/
      '/import'
    when /newsession/
      '/pages/newsession'
    when /(the|my)? dashboard/
      '/dashboard'
    when /[the ]?(view|edit|respond) page for the (.*) record with a (.*) of (.*)/
      "/#{$2.pluralize}/#{eval "#{$2.singularize.capitalize}::find_by_#{$3}(#{$4}).id"}#{$1 == 'view' ? '' : "/#{$1}"}"
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
