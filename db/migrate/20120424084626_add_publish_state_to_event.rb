class AddPublishStateToEvent < ActiveRecord::Migration
  def change
    add_column :events, :publish_state, :string
  end
end
