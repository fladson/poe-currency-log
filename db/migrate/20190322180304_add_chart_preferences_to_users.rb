class AddChartPreferencesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :chart_preferences, :jsonb, null: false, default: {}
  end
end
