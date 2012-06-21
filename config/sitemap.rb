SitemapGenerator::Sitemap.default_host = "http://www.bettercareguide.org"

SitemapGenerator::Sitemap.create do
  add 'contact_path'
  add 'help_path'
  add 'about_path'
  add 'textile_path'
  add 'terms_path'
  add 'privacy_path'
  add 'opensource_path'
  add 'provider_guide_path'

  Service.where('deregistration_date is null').order('cached_rating desc,  updated_at desc').each do |service|
    add service_path(service), :lastmod => service.updated_at
  end
end
