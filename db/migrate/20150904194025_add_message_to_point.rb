class AddMessageToPoint < ActiveRecord::Migration
  def change
    add_column :points, :message, :text
  end
end
