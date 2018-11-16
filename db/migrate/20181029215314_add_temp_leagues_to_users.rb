class AddTempLeaguesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :temp_leagues, :string, array: true, default: []
  end
end
