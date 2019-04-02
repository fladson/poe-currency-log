class AddLeaguesFieldToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :leagues, :jsonb, null: false, default: {}
  end
end
