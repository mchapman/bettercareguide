module ServicesHelper

  def prepare_link(href)
    if href =~ /http:\/\//
      href
    else
      "http://#{href}"
    end
  end

end
