module AddressesHelper

  public
    @@local_field_names_uk = ['Street 1','Street 2','Street 3','Town','County','Postcode']
    @@base_field_names = %w(line1 line2 line3 city state postal_zip_code)

  def self.base_field_names
    @@base_field_names
  end

  def self.local_field_name(field)
    if field.instance_of? Fixnum
      lineno = field
    else
      lineno = @@base_field_names.index(field)
    end
    @@local_field_names_uk[lineno]
  end
  
  def put_commas_in_address(address)
    result = address.line1
    @@base_field_names[1..5].each {|att_name| result += ", " + address[att_name] if address[att_name] && address[att_name].strip != ''}
    return result
  end

end
