class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :subscibe_limit_date, :date
    add_column :events, :end_date, :date
    rename_column :events, :date, :begin_date
    add_column :events, :attendance, :string
    add_column :events, :contacts, :text
    ##
    add_column :events, :how_to_participate, :text
    add_column :events, :registration_fees, :text
    add_column :events, :participants, :text
    add_column :events, :related_events, :text
    add_column :events, :infos_extra, :text
  end
end
