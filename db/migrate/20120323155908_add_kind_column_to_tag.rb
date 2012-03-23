class AddKindColumnToTag < ActiveRecord::Migration
  def change
    add_column :tags, :context, :string
  end
end
