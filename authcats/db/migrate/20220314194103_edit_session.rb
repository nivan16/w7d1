class EditSession < ActiveRecord::Migration[5.2]
  def change
    add_index :sessions, :session_token, unique: true
  end
end
