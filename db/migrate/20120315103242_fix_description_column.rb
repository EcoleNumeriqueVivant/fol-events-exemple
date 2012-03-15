class FixDescriptionColumn < ActiveRecord::Migration
  def change
    rename_column :events, :descrition, :description
  end  
end
