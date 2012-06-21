class AddEffectiveDateToRates < ActiveRecord::Migration
  def self.up
    add_column :rates, :effective_date, :date
  end

  def self.down
    remove_column :rates, :effective_date
  end
end
