# frozen_string_literal: true

class CreateCurrencyLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_logs do |t|
      t.references :user, foreign_key: true
      t.string :league, null: false, default: ''
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
    add_index :currency_logs, :league
  end
end
