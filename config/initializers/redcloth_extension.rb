module RedCloth::Formatters::HTML
  include RedCloth::Formatters::Base

  def link(opts)
    "<a href=\"#{escape_attribute opts[:href]}\"#{pba(opts)} rel=\"nofollow\" target=\"_blank\">#{opts[:name]}</a>"
  end

  private

  # HTML cleansing stuff
  ALLOWED_TAGS = {
  'a' => ['href', 'title'],
  'br' => [],
  'i' => nil,
  #'u' => nil,
  #'b' => nil,
  #'pre' => nil,
  #'kbd' => nil,
  #'code' => ['lang'],
  #'cite' => nil,
  'strong' => nil,
  'em' => nil,
  #'ins' => nil,
  #'sup' => nil,
  #'sub' => nil,
  #'del' => nil,
  #'table' => nil,
  #'tr' => nil,
  #'td' => ['colspan', 'rowspan'],
  #'th' => nil,
  'ol' => ['start'],
  'ul' => nil,
  'li' => nil,
  'p' => nil
  }

  def clean_html( text, tags = ALLOWED_TAGS )
    text.gsub!( /<!--\[CDATA\[/, '' )
    text.gsub!( /<(\/*)(\w+)([^-->]*)>/ ) do
      raw = $~
      tag = raw[2].downcase
      if tags.has_key? tag
        pcs = [tag]
        pcs << "rel=\"nofollow\"" if (tag == 'a' and raw[1]=='')
        tags[tag].each do |prop|
          ['"', "'", ''].each do |q|
            q2 = ( q != '' ? q : '\s' )
            if raw[3] =~ /#{prop}\s*=\s*#{q}([^#{q2}]+)#{q}/i
              attrv = $1
              next if prop == 'src' and attrv =~ %r{^(?!http)\w+:}
              pcs << "#{prop}=\"#{$1.gsub('"', '\\"')}\"" unless $1.nil?
              break
            end
          end
        end if tags[tag]
        "<#{raw[1]}#{pcs.join " "}>"
      else
        " "
      end
    end
  end

end