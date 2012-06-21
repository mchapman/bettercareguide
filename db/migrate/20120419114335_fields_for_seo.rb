class FieldsForSeo < ActiveRecord::Migration
  def change
    create_table :friendly_id_slugs do |t|
      t.string   :slug,           :null => false
      t.integer  :sluggable_id,   :null => false
      t.string   :sluggable_type, :limit => 40
      t.datetime :created_at
    end
    add_index :friendly_id_slugs, :sluggable_id
    add_index :friendly_id_slugs, [:slug, :sluggable_type], :unique => true
    add_index :friendly_id_slugs, :sluggable_type

    add_column :services, :slug, :string
    add_index :services, :slug

    add_column :internal_service_types, :seo_keywords, :string
    add_column :internal_service_types, :seo_single_word, :string, :limit => 25
    keywords = [['residential, care home, residential care, old peoples home','residential care'],
                ['domiciliary, home care, domiciliary care, homecare, care at home','home care'],
                ['residential, care home, nursing home, residential care, old peoples home','nursing home']]
    keywords.each_index do |a|
      i = InternalServiceType.find(a+1)
      i.seo_keywords = keywords[a][0]+', care, adult social care, eldercare'
      i.seo_single_word = keywords[a][1]
      i.save
    end
    puts "Now do ActiveRecord::Base.logger.level = 3; Service.where('slug is null').order('deregistration_date desc').each(&:save) in the console"
  end
end
