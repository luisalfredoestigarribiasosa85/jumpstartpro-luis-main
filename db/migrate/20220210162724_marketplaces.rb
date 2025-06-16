class Marketplaces < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_column :users, :account_id, :integer
    add_column :accounts, :account_id, :integer

    remove_index :users, :email
    add_index :users, [:email, :account_id], unique: true, algorithm: :concurrently
  end
end
