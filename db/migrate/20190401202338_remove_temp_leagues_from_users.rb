class RemoveTempLeaguesFromUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :temp_leagues
  end
end
