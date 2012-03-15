class AddAddress < ActiveRecord::Migration
  def change
      create_table :addresses do |t|
          t.string :line1, :default => ''
          t.string :line2, :default => ''
          t.string :city, :default => ''
          t.string :state, :default => ''
          t.string :country, :default => ''
          t.string :zip, :default => ''
          t.integer :addressable_id
          t.string  :addressable_type, :default => ''
          t.float :latitude
          t.float :longitude
        end
        add_index :addresses, [:addressable_type, :addressable_id], :unique => true
  end
end
