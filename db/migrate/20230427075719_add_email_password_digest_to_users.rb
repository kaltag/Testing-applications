class AddEmailPasswordDigestToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :name, :email
    add_column :users, :password_digest, :string
    add_index :users, :email, unique: true
  end
end
