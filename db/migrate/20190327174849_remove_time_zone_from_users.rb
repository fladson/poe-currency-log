class RemoveTimeZoneFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :time_zone
  end
end
