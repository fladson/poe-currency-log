class AddFieldsToUserSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :user_settings, :currency, :string
    add_column :user_settings, :color, :string
    add_column :user_settings, :sort, :integer
    add_column :user_settings, :hidden, :boolean, default: :false
  end
end
