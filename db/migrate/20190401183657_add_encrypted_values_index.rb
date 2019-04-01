class AddEncryptedValuesIndex < ActiveRecord::Migration[5.1]
  def change
      add_index :users, :encrypted_account_name_iv, unique: true
      add_index :users, :encrypted_session_iv, unique: true
  end
end
