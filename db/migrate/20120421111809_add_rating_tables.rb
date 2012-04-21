
class AddRatingTables < ActiveRecord::Migration
    def self.up
      ActiveRecord::Base.create_ratings_table
      
      Event.add_ratings_columns
    end
    
    # def self.down
    #      # Remove the columns we added
    #      Car.remove_ratings_columns
    #      
    #      drop_table :movies rescue nil
    #      drop_table :cars rescue nil
    # 
    #      ActiveRecord::Base.drop_ratings_table
    #    end
  end