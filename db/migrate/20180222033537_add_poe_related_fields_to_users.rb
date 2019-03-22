# frozen_string_literal: true

class AddPoeRelatedFieldsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :encrypted_account_name, :string, null: false, default: ''
    add_column :users, :encrypted_account_name_iv, :string
    add_column :users, :encrypted_session, :string, null: false, default: ''
    add_column :users, :encrypted_session_iv, :string
    add_column :users, :chars, :jsonb, null: false, default: {}
    add_column :users, :valid_credentials, :boolean, null: false, default: false
  end
end
