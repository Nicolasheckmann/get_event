class RenameColumnOfEvents < ActiveRecord::Migration[5.2]
  def change
    rename_column :events, :decription, :description
  end
end
