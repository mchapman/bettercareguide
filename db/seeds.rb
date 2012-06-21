# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# The id's are 'hard' coded - determining which address, phone number appears on various screens
address_type = AddressType.new(:description => 'Registered Address')
address_type.id = 1
address_type.save!

address_type = AddressType.new(:description => 'Office Address')
address_type.id = 2
address_type.save!

phone_type = PhoneType.new(:description => 'Landline')
phone_type.id = 1
phone_type.save!

phone_type = PhoneType.new(:description => 'Fax')
phone_type.id = 2
phone_type.save!

Town.create(:name => 'UCKFIELD', :lat => 50.9724555, :lng => 0.0971166)
Town.create(:name => 'TAUNTON', :lat => 51.0146, :lng => -3.1034)
