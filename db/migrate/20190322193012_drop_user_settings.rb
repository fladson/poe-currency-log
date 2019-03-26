class DropUserSettings < ActiveRecord::Migration[5.1]
  def change
    drop_table :user_settings
  end
end
