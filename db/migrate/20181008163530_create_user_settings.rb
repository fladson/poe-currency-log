# frozen_string_literal: true

class CreateUserSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :user_settings do |t|
      t.references :user, foreign_key: true
      t.jsonb :data, null: false, default: {}

      t.timestamps
    end
  end
end
